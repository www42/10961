# Exercise 1: Creating files and folders on a remote computer
# -----------------------------------------------------------

# -------
# LON-CL1
# -------

# Create a new folder on a remote computer
Get-Help New-Item –ShowWindow
New-Item –Path \\Lon-Svr1\C$\ –Name ScriptShare –ItemType Directory

# Create a new PSDrive mapping to the remote file folder
Get-Help New-PSDrive –ShowWindow
New-PSDrive –Name ScriptShare –Root \\Lon-Svr1\c$\ScriptShare –PSProvider FileSystem

# Create a file on the mapped drive
Set-Location ScriptShare:
New-Item script.txt
Get-ChildItem


# Exercise 2: Creating a registry key for your future scripts
# -----------------------------------------------------------

# Create the registry key to store script configurations
Get-ChildItem -Path HKCU:\Software
New-Item –Path HKCU:\Software –Name Scripts

# Create a new registry setting to store the name of the PSDrive
Set-Location HKCU:\Software\Scripts
New-ItemProperty -Path HKCU:\Software\Scripts -Name "PSDriveName" –Value "ScriptShare"
Get-ItemProperty . -Name PSDriveName



# Exercise 3: Create a new Active Directory group
# -----------------------------------------------

# Create a PSDrive that maps to the Users container in AD DS
Import-Module ActiveDirectory
New-PSDrive -Name “AdatumUsers” -Root "CN=users,DC=Adatum,DC=com" -PSProvider ActiveDirectory
Set-Location "AdatumUsers:"

# Create the London Developers group
New-Item -ItemType group -Path . -Name "CN=London Developers"
Get-ChildItem .