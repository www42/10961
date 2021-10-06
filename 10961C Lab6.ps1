# 10961 C Module 06
# ==================

# Exercise 1: Querying information by using WMI
# ---------------------------------------------
# 1. Sign in to LON-CL1
# 2. Open PowerShell as Administrator
# 3. Find Repository that Lists IP
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*configuration*' | Sort Name

# 4. Retrieve All Instances of Class Showing DHCP IP
Get-WmiObject –Class Win32_NetworkAdapterConfiguration | Where DHCPEnabled –eq $False | Select IPAddress

# 5. Find Repository that List OS Information
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*operating*' | Sort Name

# 6. List Properties for Win32_OperatingSystem
Get-WmiObject –Class Win32_OperatingSystem | Get-Member

# 7. Display OS Version, Service Pack Version and Build
Get-WmiObject –Class Win32_OperatingSystem | Select Version,ServicePackMajorVersion,BuildNumber

# 8. Find Repository Containing Computer-System Info
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*system*' | Sort Name

# 9. List Properties and Property Values for Class
Get-WmiObject –class Win32_ComputerSystem | Format-List –Property *

# 10. Show Computers Manufacturer, Model and RAM
Get-WmiObject –class Win32_ComputerSystem | Select Manufacturer,Model,@{n='RAM';e={$PSItem.TotalPhysicalMemory}}

# 11. Locate Repository Class for Service Information
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*service*' | Sort Name

# 12. List Properties and Property Values for Class
Get-WmiObject –Class Win32_Service | FL *

# 13. List Service Name, Status, and Sign-in Name
Get-WmiObject –Class Win32_Service –Filter "Name LIKE 'S%'" | Select Name,State,StartName




# Exercise 2: Querying information by using CIM
# ---------------------------------------------

# 1. Locate Repository Class for User Accounts
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*user*' | Sort Name 

# 2. List Win32_UserAccount Properties
Get-CimInstance –Class Win32_UserAccount | Get-Member

# 3. List User Accounts
Get-CimInstance –Class Win32_UserAccount | Format-Table –Property Caption,Domain,SID,FullName,Name

# 4. Find Repository Class for BIOS Information
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*bios*' | Sort Name

# 5. List BIOS Information
Get-CimInstance –Class Win32_BIOS

# 6. Display Win32_NetworkAdapterConfiguration Class
Get-CimInstance –Classname Win32_NetworkAdapterConfiguration

# 7. Display All Instances of Previous Class on LON-DC1
Get-CimInstance –Classname Win32_NetworkAdapterConfiguration –ComputerName LON-DC1

# 8. Find Class that Lists User Groups
Get-WmiObject –namespace root\cimv2 –list | Where Name –like '*group*' | Sort Name

# 9. List Groups that Exist on LON-DC1
Get-CimInstance –ClassName Win32_Group –ComputerName LON-DC1




# Exercise 3: Invoking methods
# ----------------------------

# 1. Restart LON-DC1 by using Win32_OperatingSystem
Invoke-CimMethod –ClassName Win32_OperatingSystem –ComputerName LON-DC1 –MethodName Reboot

# 2. Switch to LON-DC1
# 3. Switch to LON-CL1
# 4. Open Computer Management
# 5. View Windows Remote Management Startup Type
# 6. Change WS-Management Startup Type
Get-WmiObject –Class Win32_Service –Filter "Name='WinRM'" | Invoke-WmiMethod –Name ChangeStartMode –Argument 'Automatic'

# 7. Confirm Startup Type Changed
