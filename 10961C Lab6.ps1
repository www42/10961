# Exercise 1: Querying information by using WMI
# ---------------------------------------------
# -------
# LON-CL1
# -------

# Query IP addresses
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*configuration*' | Sort Name
Get-WmiObject –Class Win32_NetworkAdapterConfiguration | Where DHCPEnabled –eq $False | Select IPAddress

# Query operating-system version information
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*operating*' | Sort Name
Get-WmiObject –Class Win32_OperatingSystem | Get-Member
Get-WmiObject –Class Win32_OperatingSystem | Select Version,ServicePackMajorVersion,BuildNumber

# Query computer-system hardware information
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*system*' | Sort Name
Get-WmiObject –class Win32_ComputerSystem | Format-List –Property *
Get-WmiObject –class Win32_ComputerSystem | Select Manufacturer,Model,@{n='RAM';e={$PSItem.TotalPhysicalMemory}}

# Query service information 
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*service*' | Sort Name
Get-WmiObject –Class Win32_Service | FL *
Get-WmiObject –Class Win32_Service –Filter "Name LIKE 'S%'" | Select Name,State,StartName


# Exercise 2: Querying information by using CIM
# ---------------------------------------------

# Query user accounts
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*user*' | Sort Name 
Get-CimInstance –Class Win32_UserAccount | Get-Member
Get-CimInstance –Class Win32_UserAccount | Format-Table –Property Caption,Domain,SID,FullName,Name

# Query BIOS information
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*bios*' | Sort Name
Get-CimInstance –Class Win32_BIOS

# Query network adapter configuration information
Get-CimInstance –Classname Win32_NetworkAdapterConfiguration
Get-CimInstance –Classname Win32_NetworkAdapterConfiguration –ComputerName LON-DC1

# Query user group information
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*group*' | Sort Name
Get-CimInstance –ClassName Win32_Group –ComputerName LON-DC1




# Exercise 3: Invoking methods
# ----------------------------

# Invoke a CIM method
Invoke-CimMethod –ClassName Win32_OperatingSystem –ComputerName LON-DC1 –MethodName Reboot

# Invoke a WMI method
Get-Service -Name WinRM | % StartType
Get-WmiObject –Class Win32_Service –Filter "Name='WinRM'" | Invoke-WmiMethod –Name ChangeStartMode –Argument 'Automatic'
Get-Service -Name WinRM | % StartType
