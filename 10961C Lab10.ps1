# 10961 C Module 10
# ==================

# ---------------------------
# Lab A: Using basic remoting
# ---------------------------

# Exercise 1: Enabling Remoting on the Local Computer
# ---------------------------------------------------
# 1. Sign in to LON-CL1
# 2. Open PowerShell as Administrator
# 3. Change Execution Policy to Remote Signed
Set-ExecutionPolicy RemoteSigned

# 4. Confirm Action
# 5. Enable Remote Incoming Connections
Enable-PSRemoting

# 6. List Commands that Contain sessionconfiguration
help *sessionconfiguration*

# 7. View Session Configurations
Get-PSSessionConfiguration


# Exercise 2: Performing One-to-One Remoting
# ------------------------------------------
# 1. Connect to LON-DC1
Enter-PSSession –ComputerName LON-DC1

# 2. Install NLB Feature
Install-WindowsFeature NLB

# 3. Close Connection
Exit-PSSession

# 4. Connect to LON-DC1
Enter-PSSession –ComputerName LON-DC1

# 5. Connect LON-DC1 to LON-CL1
Enter-PSSession -ComputerName LON-CL1    # does not work, second hop is not allowed

# 6. Close Connection
Exit-PSSession

# 7. Connect to Localhost
Enter-PSSession -ComputerName localhost

# 8. Open Notepad
notepad  # Shell has no way to show window

# 9. Cancel Process
<Ctrl-C>

# 10. Exit Connection
Exit-PSSession




# Exercise 3: Performing One-to-Many Remoting
# -------------------------------------------
# 1. Get Commands Containing Adapter
help *adapter*

# 2. View Help for Get-NetAdapter
help Get-NetAdapter
help Get-NetAdapter -Parameter Physical

# 3. Run Command on LON-DC1 and LON-CL1
Invoke-Command –ComputerName LON-CL1, LON-DC1 { Get-NetAdapter –Physical }

# 4. View Members of Get-Process
Get-Process | Get-Member

# 5. View members From Remote Process Object
Invoke-Command –ComputerName LON-DC1 { Get-Process } | Get-Member

# 6. Close All Windows






# -----------------------
# Lab B: Using PSSessions
# -----------------------

# Exercise 1: Using Implicit Remoting
# -----------------------------------
# 1. Open PowerShell
# 2. Create Persistent Connection to LON-DC1
$dc = New-PSSession -ComputerName LON-DC1

# 3. Connection 
$dc

# 4. Display List of Modules for LON-DC1
Get-Module –ListAvailable –PSSession $dc

# 5. Find Module that Can Work with SMB Shares
Get-Module –ListAvailable –PSSession $dc | where {$_.Name -Like '*share*'}

# 6. Import Modules from LON-DC1
Import-Module –PSSession $dc –Name SMBShare –Prefix DC

# 7. List Shares on LON-DC1
Get-DCSmbShare

# 8. List Shares on Local Computer
Get-SmbShare

# 9. Remove Session
Get-PSSession | Remove-PSSession

# 10. Confirm All Sessions have Been Closed
Get-PSSession



# Exercise 2: Managing Multiple Computers
# ---------------------------------------
# 1. Create PSSesion to LON-CL1 and LON-DC1
$computers = New-PSSession –ComputerName LON-CL1, LON-DC1

# 2. Confirm Both Connections are Available
$computers

# 3. Find Module for Working with Network Security
Get-Module *security* –ListAvailable

# 4. Load Module on LON-CL1 and LON-DC1
Invoke-Command –Session $computers { Import-Module NetSecurity }

# 5. Find Command to Display Firewall Rules
Get-Command –Module NetSecurity
Help Get-NetFirewallRule -ShowWindow

# 6. List Enabled Firewall Rules
Invoke-Command –Session $computers –ScriptBlock { Get-NetFirewallRule –Enabled True } |
    Select Name, PSComputerName

# 7. List Local Hard Drives
Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3"

# 8. Run Same Command on LON-DC1 and LON-CL1
Invoke-Command –Session $computers { Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3" }

# 9. Produce HTML Report for Previous Command
Invoke-Command –Session $computers –ScriptBlock { Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3" } |
    ConvertTo-Html –Property PSComputerName, DeviceID, FreeSpace, Size

# 10. Close PSSessions
Get-PSSession | Remove-PSSession
