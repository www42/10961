# 10961 C Module 12
# ==================

# Exercise 1: Creating a Profile Script
# -------------------------------------
# 1. Sign in to LON-CL1
# 2. A Note About this Exercise
# 3. Find Command to Query Domain Controllers
Get-Help *DomainController*

# 4. Identify Way to Only Query Servers
# 5. Create Profile Script
$MyDCs = Get-ADDomainController
$MyServers = Get-ADComputer -Filter {Operatingsystem -like "*server*"}

# 6. Place Script in Location for Your User Account
New-Item -ItemType File -Path $profile.CurrentUserCurrentHost -Force

# 7. Confirm Script Populated the Variables
$MyDCs
$MyServers

# 8. Update Script to Only Contain Names
$MyDCs = Get-ADDomainController | select -ExpandProperty Name
$MyServers = Get-ADComputer -Filter {Operatingsystem -like "*server*"}  | select -ExpandProperty Name




# Exercise 2: Verifying the Validity of an IP Address
# ---------------------------------------------------
# 1. Note About this Exercise
# 2. Find Regular Expression to Verify Parttern of IPs
# 3. Find Method to Divide IP Addreses into Octets
# 4. Create Script to Request IP Address
$ip = Read-Host "Enter an IP address"

If ($ip -match "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$") {
    Write-Host "IP pattern is valid"
} Else {
    Write-Host "IP pattern is not valid"
}

$octets = $ip.Split(".")

Foreach ($o in $octets) {
    [int]$value = $o
    If ($value -ge 0 -and $value -le 255) {
        Write-Host "Octet $value is valid"
    } Else {
        Write-Host "Octet $value is not valid"
    }
}


# Exercise 3: Reporting Disk Information
# --------------------------------------
# 1. Note About this Exercise
# 2. Create Script to Accept -ComputerName Parameter
Param(
    $ComputerName
)

# 3. Find How to Use Get-Volume for Remote Computers
$cim = New-CimSession $ComputerName
$drives = Get-Volume -CimSession $cim

# 4. Filter for Only Volume on Hard Drives
$cim = New-CimSession $ComputerName
$drives = Get-Volume -CimSession $cim | Where-Object DriveType -eq "Fixed"

# 5. Sort Volumes By Drive Letter
$cim = New-CimSession $ComputerName
$drives = Get-Volume -CimSession $cim | Where-Object DriveType -eq "Fixed" | Sort-Object -Property DriveLetter

# 6. Display Name of Queried Computers
Write-Host "Drives on $ComputerName"

# 7. Display Columns for Drive, Size, and Free
Write-Host "Drives on $ComputerName"
"{0,-5} {1,10} {2,15}" -f "Drive","Size","Free"

# 8. Display Information for Each Volume
Foreach($drive in $drives) {
    "{0,-5} {1,10:n2} {2,15:n2}" -f $drive.DriveLetter,($drive.Size/1GB),($drive.SizeRemaining/1GB)
}

# 9. Confirm Script Works
Param(
    $ComputerName
)

$cim = New-CimSession $ComputerName
$drives = Get-Volume -CimSession $cim | Where-Object DriveType -eq "Fixed" | Sort-Object -Property DriveLetter

Write-Host "Drives on $ComputerName"
"{0,-5} {1,10} {2,15}" -f "Drive","Size","Free"

Foreach($drive in $drives) {
    "{0,-5} {1,10:n2} {2,15:n2}" -f $drive.DriveLetter,($drive.Size/1GB),($drive.SizeRemaining/1GB)
}

# 10. Add Status Column and Edit Free Column
# 11. Confirm Script is Working
Param(
    $ComputerName
)

$cim = New-CimSession $ComputerName
$drives = Get-Volume -CimSession $cim | Where-Object DriveType -eq "Fixed" | Sort-Object -Property DriveLetter

Write-Host "Drives on $ComputerName"
"{0,-5} {1,10} {2,15} {3,-10}" -f "Drive","Size","Free","Status"

Foreach($drive in $drives) {
    If ($drive.SizeRemaining -le 10GB) {
        $status = "Low"
    } Else {
        $status = "OK"
    }
    "{0,-5} {1,10:n2} {2,15:n2} {3,-10}" -f $drive.DriveLetter,($drive.Size/1GB),($drive.SizeRemaining/1GB),$status
}




# Exercise 4: Querying NTFS Permissions
# -------------------------------------
# 1. Note About this Exercise
# 2. Create Script for Get-NTFS Function
function Get-NTFS {
    param(
        [string]$Path=(Read-Host "Enter file or folder to get permissions for"),
        [switch]$Full
    )
}

# 3. Find How to Display Rules from an ACL
$acl = Get-Acl $Path

# 4. Confirm You can Query Rules
function Get-NTFS {
    param(
        [string]$Path=(Read-Host "Enter file or folder to get permissions for"),
        [switch]$Full
    )

    $acl = Get-Acl $Path
}
Get-NTFS -Path C:\Users

# 5. Add Ability to Request Folder Path
function Get-NTFS {
    param(
        [string]$Path=(Read-Host "Enter file or folder to get permissions for"),
        [switch]$Full
    )

    $acl = Get-Acl $Path

    If ($Full -eq $true) {
        $acl.Access
    } Else {
        $acl.AccessToString
    }
}

# 6. Save Script as Module
# 7. Confirm You can Call the Function
Get-NTFS -Path C:\Users



# Exercise 5: Creating User Accounts with Passwords from a CSV File
# -----------------------------------------------------------------
# 1. Note About this Exercise
# 2. View users.csv Contents
E:\Mod12\labfiles\users.csv

# 3. Create Script for -CsvFile Parameter
New-Item -ItemType file -path .\ImportUser.ps1

param(
    $CsvFile = "NoFile"
)

If ($CsvFile -eq "NoFile") {
    Write-Host "CSV file not entered"
    Exit
}

# 4. Import and Create Users from CSV File
$users=Import-Csv $CsvFile

Foreach($user in $users) {
    $display = $user.First + " " + $user.Last
    $upn = $user.UserID + "@adatum.com"
    $password = $user.Password | ConvertTo-SecureString -AsPlainText -Force
    $OU = "OU=" + $user.Department + ",DC=adatum,DC=com"
    New-ADUser -Name $display -DisplayName $display -GivenName $user.First -Surname $user.Last -SamAccountName $user.UserID -UserPrincipalName $upn -AccountPassword $password -ChangePasswordAtLogon $true -Enabled $true -path $OU
}

# 5. Confirm Users Were Created
.\ImportUser.ps1 -CsvFile users.csv
