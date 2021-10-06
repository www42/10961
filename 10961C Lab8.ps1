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
# 1. Open PowerShell
# 2. Create Group Named IPPhoneTest
New-ADGroup -Name IPPhoneTest -GroupScope Universal -GroupCategory Security

# 3. Move IPPhoneTest to IT OU
Move-ADObject "CN=IPPhoneTest,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=IT,DC=Adatum,DC=com"

# 4. Add Users to IPPhoneTest Group
Add-ADGroupMember IPPhoneTest -Members Abbi, Ida, Parsa, Tonia

# 5. Create ipPhone.ps1 File
New-Item -ItemType File -Path E:\Mod08\Labfiles\ipPhone.ps1
psEdit E:\Mod08\Labfiles\ipPhone.ps1

# 6. Create Query for IPPhoneTest Membership
$users = Get-ADGroupMember IPPhoneTest

# 7. Create ForEach Loop to Process Users
ForEach ($u in $users) {
    $fullUser = Get-ADUser $u
    $ipPhone = $fullUser.GivenName + "." + $fullUser.Surname + "@adatum.com"
    Set-ADUser $fullUser -replace @{ipPhone = "$ipPhone"}
}

# 8. Run ipPhone.ps1
E:\Mod08\Labfiles\ipPhone.ps1





# Exercise 3: Processing Items by Using If Statements
# ---------------------------------------------------
# 1. Open PowerShell
# 2. Set Work Location to E:\Mod08\Labfiles
Set-Location E:\Mod08\Labfiles

# 3. Create File Named services.txt
New-Item services.txt -ItemType File

# 4. Find Print Spooler Name and Add it to services.txt
Get-Service "Print Spooler" | Select -ExpandProperty Name | Out-File .\services.txt -Append

# 5. Find Windows Time Name and Add it to services.txt
Get-Service "Windows Time" | Select -ExpandProperty Name | Out-File .\services.txt -Append

# 6. Create Script Named StartServices.ps1
New-Item -ItemType file -Path E:\Mod08\Labfiles\StartServices.ps1

# 7. Add Service Names to Variables from services.txt
$Services = Get-Content .\services.txt

# 8. Use Loop to Process Each Service
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
# 1. Create Script Named CreatePasswords.ps1
New-Item -ItemType file -Path E:\Mod08\Labfiles\CreatePasswords.ps1

# 2. Set $passwordLength Variable
$passwordLength = 8

# 3. Use For to Construct Loop
$password = $null
for ($i = 0; $i -le $passwordLength; $i++) {
    $number = Get-Random -Minimum 65 -Maximum 90
    $letter = [char]$number
    $password += $letter
}

# 4. Set the Password to Display on Screen
Write-Output "The password is: $password"





# Exercise 5: Creating Users Based on a CSV File
# ----------------------------------------------
# 1. Create Script Named CreateUsers.ps1
New-Item -ItemType file -Path E:\Mod08\Labfiles\CreateUsers.ps1

# 2. Set Script to Store users.csv Contents in Variable
$users = Import-Csv -Path users.csv

# 3. Create ForEachLoop to Create Users
ForEach ($u in $users) {
    $path = "OU=" + $u.Department + ",DC=Adatum,DC=com"
    $upn = $u.UserID + "@adatum.com"
    $display = $u.First + " " + $u.Last
    Write-Host "Creating $display in $path"
    New-ADUser -GivenName $u.First -Surname $u.Last -Name $display -DisplayName $display -SamAccountName $u.UserID -UserPrincipalName $UPN -Path $path -Department $u.Department
}
