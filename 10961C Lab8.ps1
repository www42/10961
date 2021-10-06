# 10961 C Module 08
# ==================

# Exercise 1: Signing a Script
# ----------------------------
#  1. Sign in to LON-CL1
#  2. Open MMC
& mmc

#  3. Begin Adding Snap-In
#  4. Add Certificates Snap-In
#  5. Select Account to Manage Certificates for
#  6. Close Add or Remove Snap-Ins
#  7. Start Certificate Enrollment Wizard
#  8. Advance Wizard
#  9. Select Enrollment Policy
# 10. Select Certificate to Enroll In
# 11. Click Finish
# 12. Confirm Code Signing Certificate was Added
# 13. Close MMC Console
# 14. Open PowerShell
# 15. Place Code Signing Certificate in CurrentUser\My
Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert

# 16. Set $cert Value
$cert = Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert

# 17. Set Work Location
Set-Location E:\Mod08\Labfiles

# 18. Rename HelloWorld.txt to HelloWorld.ps1
Rename-Item .\HelloWorld.txt .\HelloWorld.ps1

# 19. Apply Digital Certificate to HelloWorld.ps1
Set-AuthenticodeSignature -FilePath .\HelloWorld.ps1 -Certificate $cert

# 20. Change Execution Policy to All Signed
Set-ExecutionPolicy AllSigned -Force

# 21. Run HelloWorld.ps1
.\HelloWorld.ps1

# 22. Change Execution Policy to Unrestricted
Set-ExecutionPolicy Unrestricted -Force

# 23. Close PowerShell






# Exercise 2: Processing an Array with a ForeEach Loop
# ----------------------------------------------------

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




# Exercise 3: Processing Items by Using If Statements
# ---------------------------------------------------

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



# Exercise 4: Creating a Random Password
# --------------------------------------

$passwordLength = 8
$password = $null
for ($i = 0; $i -le $passwordLength; $i++) {
    $number = Get-Random -Minimum 65 -Maximum 90
    $letter = [char]$number
    $password += $letter
}
Write-Output "The password is: $password"



# Exercise 5: Creating Users Based on a CSV File
# ----------------------------------------------

$users = Import-Csv -Path users.csv
ForEach ($u in $users) {
    $path = "OU=" + $u.Department + ",DC=Adatum,DC=com"
    $upn = $u.UserID + "@adatum.com"
    $display = $u.First + " " + $u.Last
    Write-Host "Creating $display in $path"
    New-ADUser -GivenName $u.First -Surname $u.Last -Name $display -DisplayName $display -SamAccountName $u.UserID -UserPrincipalName $UPN -Path $path -Department $u.Department
}
