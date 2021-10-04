# 10961 C Module 03
# ==================

# ---------------------------------------------
# Lab A:Selecting, Sorting, and Displaying Data
# ---------------------------------------------
# 1. Sign in to LON-CL1
# 2. Open PowerShell as Administrator
# 3. List Commands Containing 'Date'
help *date*

# 4. List Members of Get-Date
Get-Date | Get-Member
Get-Date | Get-Member -Name DayOfYear 

# 5. Get Day of Year
Get-Date | Select-Object –Property DayOfYear

# 6. Format Day of Year List
Get-Date | Select-Object -Property DayOfYear | fl

# 7. List Commands Containing 'Hotfix'
Get-Command *hotfix*
Get-Command Get-HotFix 

# 8. List Members of Get-Hotfix
Get-Hotfix | Get-Member

# 9. Select Get-Hotfix Objects
Get-Hotfix | Select-Object –Property HotFixID,InstalledOn,InstalledBy

# 10. Get HotFixID Age
Get-Hotfix | Select-Object –Property HotFixID,@{n='HotFixAge';e={(New-TimeSpan -Start $PSItem.InstalledOn).Days}},InstalledBy

# 11. List Commands Containing 'Scope'
help *scope*
Get-Command Get-DHCPServerv4Scope

# 12. Open Help for Get-DHCPServerv4Scope
Help Get-DHCPServerv4Scope –ShowWindow

# 13. Get IPv4 Scope for LON-DC1
Get-DhcpServerv4Scope -ComputerName LON-DC1

# 14. Get Just the ScopeID, SubnetMask and Name
Get-DhcpServerv4Scope -ComputerName LON-DC1 | select ScopeId,Name,SubnetMask | fl

# 15. List Commands Containing 'Help'
help *rule*
Get-Command Get-NetFirewallRule

# 16. Get Firewall Rules
Get-NetFirewallRule

# 17. Open Help for Get-NetFirewallRule
Help Get-NetFirewallRule –ShowWindow

# 18. List Enabled Firewall Rules
Get-NetFirewallRule –Enabled True

# 19. Format List of Enabled Firewall Rules
Get-NetFirewallRule –Enabled True | Format-Table -wrap

# 20. Get Firewall Rules Grouped by Profile
Get-NetFirewallRule –Enabled True | Select-Object –Property DisplayName,Profile,Direction,Action | Sort-Object –Property Profile, DisplayName | ft -GroupBy Profile

# 21. List Commands Containing 'Neighbor'
help *neighbor*
Get-Command Get-NetNeighbor

# 22. Open Help for Get-NetNeighbor
help Get-NetNeighbor –ShowWindow

# 23. Run Get-NetNeighbor
Get-NetNeighbor

# 24. Sort Results by State
Get-NetNeighbor | Sort-Object –Property State

# 25. Sort Results by State and Format
Get-NetNeighbor | Sort-Object –Property State | Select-Object –Property IPAddress,State | Format-Wide -GroupBy State -AutoSize

# 26. Test Connection to LON-DC1
Test-NetConnection LON-DC1

# 27. Test Connection to LON-CL1
Test-NetConnection LON-CL1

# 28. List Commands Containing 'Cache'
help *cache*
Get-Command Get-DnsClientCache

# 29. Get DNS Cache
Get-DnsClientCache

# 30. Get, Select Objects and Sort DNS Cache
Get-DnsClientCache | Select Name,Type,TimeToLive | Sort Name | Format-List

# 31. Close All Windows




# ------------------------
# Lab B: Filtering Objects
# ------------------------
# 1. Open PowerShell as Administrator (LON-CL1)
# 2. List Commands Containing 'User'
help *user*

# 3. Open Help for Get-ADUser
Get-Help Get-ADUser -ShowWindow

# 4. List AD Users
Get-ADUser -Filter * | ft

# 5. Get Users in Users Container
Get-ADUser -Filter * -SearchBase "cn=users,dc=adatum,dc=com" | ft

# 6. Get Number of Events with ID of 4624
Get-EventLog -LogName Security | where EventID -EQ 4624 | Measure-Object  | fw

# 7. Get Date and Time of Events with ID of 4624
Get-EventLog -LogName Security | Where EventID -eq 4624 | Select TimeWritten,EventID,Message

# 8. Get Last 10 Events with ID of 4624
Get-EventLog -LogName Security | where EventID -EQ 4624 | Select TimeWritten,EventID,Message -Last 10 | ft

# 9. Get Certificates
Get-ChildItem -Path cert: -Recurse

# 10. Display Members of Objects
Get-ChildItem -Path cert: -Recurse | Get-Member

# 11. Display Objects that don't have a Private Key
Get-ChildItem -Path CERT: -Recurse | Where HasPrivateKey -eq $False | Select-Object -Property FriendlyName,Issuer | fl

# 12. Display Encryption Certs
Get-ChildItem -Path CERT: -Recurse | Where { $PSItem.HasPrivateKey -eq $False -and $PSItem.NotAfter -gt (Get-Date) -and $PSItem.NotBefore -lt (Get-Date) } | Select-Object -Property NotBefore,NotAfter, FriendlyName,Issuer | ft -wrap

# 13. Get All Volumes
help *volume*
Get-Volume

# 14. List Members for Get-Volume
Get-Volume | Get-Member

# 15. List Volumes with More Than 0 Size Remaining
Get-Volume | where {$_.SizeRemaining -gt 0}

# 16. Refine Previous List
Get-Volume | where {$_.SizeRemaining -gt 0 -and $_.SizeRemaining / $_.Size -lt .99 } |
             Select-Object DriveLetter, @{n='Size';e={'{0:N2}' -f ($_.Size/1MB)}}

# 17. List Volumes with Less Than 10 Percent Free Space
Get-Volume | Where-Object { $_.SizeRemaining -gt 0 -and $_.SizeRemaining / $_.Size -lt .1 }

# 18. List Commands Containing Control
help *control*
Get-Command Get-ControlPanelItem

# 19. List Control Panel Items
Get-ControlPanelItem

# 20. List System and Security Items
Get-ControlPanelItem -Category "System and Security" | sort Name

# 21. List Only System and Security Items
Get-ControlPanelItem -Category 'System and Security' | Where-Object {-not ($_.Category -notlike '*System and Security*')} | Sort Name

# 22. Close All Windows




# --------------------------
# Lab C: Enumerating Objects
# --------------------------
# 1. Open PowerShell as Administrator
# 2. List E Drive Files and Folders
Get-ChildItem -Path E: -Recurse

# 3. List E Drive File Members
Get-ChildItem -Path E: -Recurse | Get-Member

# 4. List Files on E Drive
Get-ChildItem -Path E: -Recurse | ForEach GetFiles

# 5. List Commands Containing 'Random'
help *random*
Get-Command Get-Random

# 6. Open Help for Get-Random
help Get-Random –ShowWindow

# 7. List 1 through 10
1..10

# 8. List 10 Random Numbers
1..10 | foreach {Get-Random -SetSeed $_}

#  9. Close Applications
# 10. Get Instances of Win32_OperatingSystem
Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges

# 11. Get Members of Previous Command
Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges | Get-Member
Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges | Get-Member -Name Reboot 

# 12. Run Command Again Using Method to Restart Computer
Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges | foreach Reboot




# -------------------------------
# Lab D: Sending output to a file
# -------------------------------
# 1. Note about the lab
# 2. Sign In to LON-CL1
# 3. Open PowerShell as Administrator
# 4. Display Members of IT Department
Get-ADUser -Filter * -Properties Department,City | where {$_.Department -eq 'IT' -and $_.City -eq 'London'} |
   select Name,Department,City | sort Name

# 5. Set Office Location for All Users to LON-A/1000
Get-ADUser -Filter * -Properties Department,City | where {$_.Department -eq 'IT' -and $_.City -eq 'London'} |
   Set-ADUser -Office 'LON-A/1000'

# 6. Display Users and Office Assignments
Get-ADUser -Filter * -Properties Department,City,Office | where {$_.Department -eq 'IT' -and $_.City -eq 'London'} |
   select Name,Department,City,Office | sort Name

# 7. Open Help for ConvertTo-Html
help ConvertTo-Html –ShowWindow

# 8. Display List and Convert to HTML
Get-ADUser -Filter * -Properties Department,City,Office |
   Where {$_.Department -eq 'IT' -and $_.City -eq 'London'} |
   Sort Name |
   Select-Object -Property Name,Department,City,Office |
   ConvertTo-Html –Property Name,Department,City -PreContent Users |
   Out-File E:\UserReport.html

# 9. Open UserReport.html
Invoke-Expression E:\UserReport.html

# 10. Convert List to XML
Get-ADUser -Filter * -Properties Department,City,Office |
   Where {$_.Department -eq 'IT' -and $PSItem.City -eq 'London'} |
   Sort Name |
   Select-Object -Property Name,Department,City,Office |
   Export-Clixml E:\UserReport.xml

# 11. Open Internet Explorer
Invoke-Item "C:\Program Files\Internet Explorer\iexplore.exe"

# 12. Open UserReport.xml
# E:\UserReport.xml

# 13. List Properties of Users in CSV File
Get-ADUser -Filter * -Properties Department,City,Office |
   Where {$_.Department -eq 'IT' -and $PSItem.City -eq 'London'} |
   Sort Name |
   Select-Object -Property Name,Department,City,Office |
   Export-Csv E:\UserReport.csv

# 14. Open UserReport.csv in Notepad
# 15. Open UserReport.csv in Excel

