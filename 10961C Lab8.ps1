# 10961C Lab 8 Basic Scripting

#region Signing a Script

& mmc
# Request new cert

$cert = dir Cert:\CurrentUser\My -CodeSigningCert

Set-Location E:\Mod08\Labfiles
Rename-Item .\HelloWorld.txt .\HelloWorld.ps1
Set-AuthenticodeSignature -FilePath .\HelloWorld.ps1 -Certificate $cert
psedit E:\Mod08\Labfiles\HelloWorld.ps1

Set-ExecutionPolicy AllSigned -Force
Get-ExecutionPolicy

.\HelloWorld.ps1

Set-ExecutionPolicy Unrestricted -Force

#endregion

#region Processing an Array with a ForeEach Loop

New-ADGroup -Name IPPhoneTest -GroupScope Universal -GroupCategory Security
Move-ADObject "CN=IPPhoneTest,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=IT,DC=Adatum,DC=com"
Add-ADGroupMember IPPhoneTest -Members Abbi, Ida, Parsa, Tonia

$users = Get-ADGroupMember IPPhoneTest

ForEach ($u in $users) {
    $fullUser = Get-ADUser $u
    $ipPhone = $fullUser.GivenName + "." + $fullUser.Surname + "@adatum.com"
    Set-ADUser $fullUser -replace @{ipPhone = "$ipPhone"}
}

Get-ADUser -Identity Abbi -Properties ipPhone | ft Name, ipPhone
Get-ADUser -Identity Beth -Properties ipPhone | ft Name, ipPhone


#endregion

#region Processing Items by Using If Statements

Set-Location E:\Mod08\Labfiles
New-Item services.txt -ItemType File
Get-Service "Print Spooler" | Select -ExpandProperty Name | Out-File .\services.txt -Append
Get-Service "Windows Time" | Select -ExpandProperty Name | Out-File .\services.txt -Append
cat .\services.txt

$Services = Get-Content .\services.txt
foreach ($s in $Services) {
    $status = (Get-Service $s).Status
    if ($status -ne "Running") {
        Start-Service $s
        Write-Host "Started $s"
    }
    else {
        Write-Host "$s is already started"
    }
}

#endregion

#region Creating a Random Password

$passwordLength = 8
$password = $null
for ($i = 0; $i -le $passwordLength; $i++) {
    $number = Get-Random -Minimum 65 -Maximum 90
    $letter = [char]$number
    $password += $letter
}
Write-Output "The password is: $password"

#endregion

#region Creating Users Based on a CSV File

$users = Import-Csv -Path users.csv
ForEach ($u in $users) {
    $path = "OU=" + $u.Department + ",DC=Adatum,DC=com"
    $upn = $u.UserID + "@adatum.com"
    $display = $u.First + " " + $u.Last
    Write-Host "Creating $display in $path"
    New-ADUser -GivenName $u.First -Surname $u.Last -Name $display -DisplayName $display -SamAccountName $u.UserID -UserPrincipalName $UPN -Path $path -Department $u.Department
}

#endregion