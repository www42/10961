#region Lab A: Selecting, Sorting, and Displaying Data

(Get-Date).DayOfYear

Get-HotFix 
Get-HotFix | select HotFixID,InstalledOn,InstalledBy
Get-HotFix | select HotFixID,@{n="HotFixAge (Days)";e={(New-TimeSpan -Start $_.InstalledOn).Days}},InstalledBy

Get-Command *dhcpserverv4* | ? verb -eq get
Get-DhcpServerv4Scope -ComputerName LON-DC1
Get-DhcpServerv4Scope -ComputerName LON-DC1 | select ScopeId,Name,SubnetMask | fl

Get-NetFirewallRule | where Enabled -EQ True 
Get-NetFirewallRule | where Enabled -EQ True | select DisplayName,Profile,Direction,Action | Sort -Property DisplayName

Get-NetNeighbor | sort state | select IPAddress,state

Test-NetConnection LON-DC1
Test-NetConnection LON-CL1
Get-DnsClientCache | sort name | select Name,Type,TimeToLive

#endregion

#region Lab B: Filtering Objects

help *user*
Get-Help Get-ADUser -ShowWindow
Get-ADUser -Filter * | ft
Get-ADUser -Filter * -SearchBase "cn=users,dc=adatum,dc=com" | ft

Get-EventLog -LogName Security | where EventID -EQ 4624 | Measure-Object
Get-EventLog -LogName Security | where EventID -EQ 4624 | Select-Object TimeWritten,EventID,Message
Get-EventLog -LogName Security | where EventID -EQ 4624 | Select-Object TimeWritten,EventID,Message -Last 10 | ft

Get-ChildItem -Path cert: -Recurse
Get-ChildItem -Path cert: -Recurse | Get-Member
Get-ChildItem -Path cert: -Recurse | where HasPrivateKey -EQ $true
Get-ChildItem -Path cert: -Recurse | where HasPrivateKey -EQ $false

help *volume*
Get-Volume | where {$_.SizeRemaining -gt 0}
Get-Volume | where {$_.SizeRemaining -gt 0 -and $_.SizeRemaining / $_.Size -lt .99 } |
             Select-Object DriveLetter, @{n='Size';e={'{0:N2}' -f ($_.Size/1MB)}}

help *control*
help *controlpanel*
Get-ControlPanelItem
Get-ControlPanelItem -Category "System and Security" | sort Name

#endregion

#region Lab C: Enumerating Objects

Get-ChildItem -Path E: -Recurse
Get-ChildItem -Path E: -Recurse | Get-Member
Get-ChildItem -Path E: -Recurse | ForEach GetFiles

help *random*
Get-Random
1..10
1..10 | foreach {Get-Random -SetSeed $_}

Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges
Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges | Get-Member
Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges | Get-Member -MemberType Methods
#Get-WmiObject -Class win32_OperatingSystem -EnableAllPrivileges | foreach Reboot

#endregion

#region Lab D: Converting Objects

Get-ADUser -Filter * -Properties Department,City | where {$_.Department -eq 'IT' -and $_.City -eq 'London'} |
   select Name,Department,City | sort Name

Get-ADUser -Filter * -Properties Department,City | where {$_.Department -eq 'IT' -and $_.City -eq 'London'} |
   Set-ADUser -Office 'LON-A/1000'

Get-ADUser -Filter * -Properties Department,City,Office | where {$_.Department -eq 'IT' -and $_.City -eq 'London'} |
   select Name,Department,City,Office | sort Name

#endregion
