
# Use LODS Course 10961C Lab Module 08 (Basic Scripting) for this extra lab.

# ------------
# Exercise DSC
# ------------
#
# Sign in to LON-CL1
#
# Create DSC configuration 'web'
configuration web
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    node ("LON-SVR1")
    {
        WindowsFeature www
        {
           Ensure = "Present"
           Name   = "Web-Server"
        }       
    }
}
web
dir .\web
psEdit .\web\LON-SVR1.mof

# Push configuration
Get-WindowsFeature -Name Web-Server -ComputerName LON-SVR1
Start-DscConfiguration -Wait -Verbose -Path .\web



# ------------
# Exercise JEA
# ------------
#
# Create AD Group
$adGroupName = 'IISAdmins'
$adUserName = 'Abbi'
New-ADGroup -Name $adGroupName -GroupCategory Security -GroupScope DomainLocal -Path 'OU=IT,DC=adatum,DC=com'
$adGroup = Get-ADGroup -Filter {sAMAccountName -eq $adGroupName}
$adUser = Get-ADUser -Filter {sAMAccountName -eq $adUserName}
Add-ADGroupMember -Identity $adGroup.SamAccountName -Members $adUser.DistinguishedName

# Install two Files on LON-SVR1
$psrcUrl = 'https://raw.githubusercontent.com/www42/10961/master/AdatumWebAdminJEARole.psrc'
$psscUrl = 'https://raw.githubusercontent.com/www42/10961/master/AdatumWebAdminEndpoint.pssc'
$psrcFile = 'C:\Program Files\WindowsPowerShell\Modules\AdatumJEA\RoleCapabilities\AdatumWebAdminJEARole.psrc'
$psscFile = 'C:\Program Files\WindowsPowerShell\Modules\AdatumJEA\RoleCapabilities\AdatumWebAdminEndpoint.pssc'

Invoke-Command -ComputerName LON-SVR1 {
    New-Item -ItemType file -Path $using:psrcFile -Force | Out-Null
    Invoke-WebRequest -Uri $using:psrcUrl -OutFile $using:psrcFile
    dir $using:psrcFile

    New-Item -ItemType file -Path $using:psscFile -Force | Out-Null
    Invoke-WebRequest -Uri $using:psscUrl -OutFile $using:psscFile
    dir $using:psscFile
}

# Register new endpoint on LON-SVR1, ignore the error message 'The WinRM client received an HTTP server error status (500)...'
$configurationName = 'adatum.windows.iismanagement'

Invoke-Command -ComputerName LON-SVR1 {
    Register-PSSessionConfiguration -Name $using:configurationName -Path $using:psscFile
}

Invoke-Command -ComputerName LON-SVR1 {
    Get-PSSessionConfiguration | ft Name,Permission -AutoSize
}

# Test
$plainPassword = 'Pa55w.rd'
$secPassword = ConvertTo-SecureString -String $plainPassword -AsPlainText -Force
$adSAMAccountName = "ADATUM\$($adUser.SamAccountName)"
$credential = New-Object System.Management.Automation.PsCredential -ArgumentList $adSAMAccountName,$secPassword

Enter-PSSession -ConfigurationName $configurationName -ComputerName LON-SVR1 -Credential $credential
Get-Command