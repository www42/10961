# 10961 C Module 05
# ==================

# Exercise 1: Creating files and folders on a remote computer
# -----------------------------------------------------------
# 1. Sign in to LON-CL1
# 2. Open PowerShell as Administrator
# 3. Read Help for New-Item
Get-Help New-Item –ShowWindow

# 4. Create Folder Named ScriptShare on \LON-SVR1\C$
New-Item –Path \\Lon-Svr1\C$\ –Name ScriptShare –ItemType Directory

# 5. Read Help for New-PSDrive
Get-Help New-PSDrive –ShowWindow

# 6. Create PSDrive Named ScriptShare
New-PSDrive –Name ScriptShare –Root \\Lon-Svr1\c$\ScriptShare –PSProvider FileSystem

# 7. Read Help for Set-Location
Get-Help Set-Location –ShowWindow

# 8. Set Working Folder to ScriptShare
Set-Location ScriptShare:

# 9. Create script.txt File
New-Item script.txt

# 10. Confirm script.txt's Creation
Get-ChildItem




# Exercise 2: Creating a registry key for your future scripts
# -----------------------------------------------------------

# 1. View HKCU:\Software Subkeys
Get-ChildItem -Path HKCU:\Software

# 2. Create Scripts Subkey
New-Item –Path HKCU:\Software –Name Scripts

# 3. Set Work Location to HKCU:\Software\Scripts
Set-Location HKCU:\Software\Scripts

# 4. Create Registry Setting to Store PSDrive
New-ItemProperty -Path HKCU:\Software\Scripts -Name "PSDriveName" –Value "ScriptShare"

# 5. Verify you can Retrieve PSDriveName Setting
Get-ItemProperty . -Name PSDriveName




# Exercise 3: Create a new Active Directory group
# -----------------------------------------------
# 1. Load ActiveDirectory Module
Import-Module ActiveDirectory

# 2. Create PSDrive
New-PSDrive -Name “AdatumUsers” -Root "CN=users,DC=Adatum,DC=com" -PSProvider ActiveDirectory

# 3. Set Work Location to AdatumUsers
Set-Location "AdatumUsers:"

# 4. Create Group in AD DS
New-Item -ItemType group -Path . -Name "CN=London Developers"

# 5. Confirm London Developers was Created
Get-ChildItem .
