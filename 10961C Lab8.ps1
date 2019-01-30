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
Add-ADGroupMember IPPhoneTest -Members Abbi,Ida,Parsa,Tonia

$users = Get-ADGroupMember IPPhoneTest

ForEach ($u in $users) {
    $fullUser = Get-ADUser $u
    $ipPhone = $fullUser.GivenName + "." + $fullUser.Surname + "@adatum.com"
    Set-ADUser $fullUser -replace @{ipPhone="$ipPhone"}
}

Get-ADUser -Identity Abbi -Properties ipPhone | ft Name,ipPhone
Get-ADUser -Identity Beth -Properties ipPhone | ft Name,ipPhone


#endregion

#region Processing Items by Using If Statements

Set-Location E:\Mod08\Labfiles
New-Item services.txt -ItemType File
Get-Service "Print Spooler" | % Name | Out-File .\services.txt -Append
Get-Service "Windows Time" | % Name | Out-File .\services.txt -Append
cat .\services.txt

$Services = Get-Content .\services.txt

#endregion

#region Creating a Random Password


#endregion

#region Creating Users Based on a CSV File


#endregion