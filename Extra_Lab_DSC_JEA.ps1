
# Use LODS Course 10961C Lab Module 08 (Basic Scripting) for this extra lab

# ------------
# Exercise DSC
# ------------
#
# LON-CL1
# -------
# Create DSC configuration 'web'
configuration web
{
    node ("LON-SVR1")
    {
        WindowsFeature www
        {
           Ensure = "Present"
           Name   = "web-server"
        }       
    }
}
web
dir .\web
psEdit .\web\LON-SVR1.mof

# Push configuration
Start-DscConfiguration -Wait -Verbose -Path .\web



# ------------
# Exercise JEA
# ------------
#
# LON-SVR1
# --------
# Install Files
$psrcUrl = 'https://raw.githubusercontent.com/www42/10961/master/AdatumWebAdminJEARole.psrc'
$psrcFile = 'C:\Program Files\WindowsPowerShell\Modules\AdatumJEA\RoleCapabilities\AdatumWebAdminJEARole.psrc'
New-Item -ItemType file -Path $psrcFile -Force
Invoke-WebRequest -Uri $psrcUrl -OutFile $psrcFile

$psscUrl = 'https://raw.githubusercontent.com/www42/10961/master/AdatumWebAdminEndpoint.pssc'
$psscFile = 'C:\Program Files\WindowsPowerShell\Modules\AdatumJEA\RoleCapabilities\AdatumWebAdminEndpoint.pssc'
New-Item -ItemType file -Path $psscFile -Force
Invoke-WebRequest -Uri $psscUrl -OutFile $psscFile

# Rgister endpoint
$configurationName = 'adatum.windows.iismanagement'
Register-PSSessionConfiguration -Name $configurationName -Path $psscFile


# LON-CL1
# -------
# Create AD Group
$adGroupName = 'IISAdmins'
$adUserName = 'Abbi'
New-ADGroup -Name $adGroupName -GroupCategory Security -GroupScope DomainLocal -Path 'OU=IT,DC=adatum,DC=com'
$adGroup = Get-ADGroup -Filter {sAMAccountName -eq $adGroupName}
$adUser = Get-ADUser -Filter {sAMAccountName -eq $adUserName}
Add-ADGroupMember -Identity $adGroup.SamAccountName -Members $adUser.DistinguishedName

# Test
$plainPassword = 'Pa55w.rd'
$secPassword = ConvertTo-SecureString -String $plainPassword -AsPlainText -Force
$adSAMAccountName = "ADATUM\$($adUser.SamAccountName)"
$credential = New-Object System.Management.Automation.PsCredential -ArgumentList $adSAMAccountName,$secPassword

Enter-PSSession -ConfigurationName $configurationName -ComputerName LON-SVR1 -Credential $credential