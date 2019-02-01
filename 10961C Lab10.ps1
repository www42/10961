# 10961C Lab 10
# -------------

# Lab A: Using basic remoting
# ---------------------------

# LON-CL1

#region Exercise 1: Enabling Remoting on the Local Computer
Set-ExecutionPolicy RemoteSigned -Force
Enable-PSRemoting -Force
help *sessionconfiguration*
Get-PSSessionConfiguration
#endregion

#region Exercise 2: Performing One-to-One Remoting
Enter-PSSession –ComputerName LON-DC1
Install-WindowsFeature NLB
Exit-PSSession

Enter-PSSession –ComputerName LON-DC1
Enter-PSSession -ComputerName LON-CL1    # does not work, second hop is not allowed
Exit-PSSession

Enter-PSSession -ComputerName localhost
notepad  # Shell has no way to show window
<Ctrl-C>
Exit-PSSession
#endregion

#region Exercise 3: Performing One-to-Many Remoting
help *adapter*
Get-NetAdapter -Physical
Invoke-Command –ComputerName LON-CL1, LON-DC1 { Get-NetAdapter –Physical }
Invoke-Command –ComputerName LON-DC1 { Get-Service } | Get-Member

#endregion

# Lab B: Using PSSessions
# -----------------------

#region Exercise 1: Using Implicit Remoting
$dc = New-PSSession -ComputerName LON-DC1
Get-Module –ListAvailable –PSSession $dc
Get-Module –ListAvailable –PSSession $dc | where Name -Like *share*
Import-Module –PSSession $dc –Name SMBShare –Prefix DC
Get-SmbShare
Get-DCSmbShare
Get-PSSession | Remove-PSSession

#endregion

#region Exercise 2: Managing Multiple Computers
$computers = New-PSSession –ComputerName LON-CL1, LON-DC1
$computers
Get-Module *security* –ListAvailable
Invoke-Command –Session $computers { Import-Module NetSecurity }
Get-Command –Module NetSecurity
Help Get-NetFirewallRule -ShowWindow
Invoke-Command –Session $computers –ScriptBlock { Get-NetFirewallRule –Enabled True } |
    Select Name, PSComputerName

Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3"
Invoke-Command –Session $computers –ScriptBlock { Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3" }
Invoke-Command –Session $computers –ScriptBlock { Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3" } |
    ConvertTo-Html –Property PSComputerName, DeviceID, FreeSpace, Size
#endregion
