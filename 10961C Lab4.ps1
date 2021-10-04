# 10961 C Module 04
# ==================

# Predicting Pipeline Behavior
# ----------------------------

# 1. Note
# 2. This command’s intent is to list the services that are running on every computer in the domain:
Get-ADComputer -Filter * | Get-Service -Name *
# Will the command achieve the goal?

# 3. This command’s intent is to list the services that are running on every computer in the domain:
Get-ADComputer -Filter * | Select-Object @{n='ComputerName';e={$_.Name}} | Get-Service -Name *
# Will the command achieve the goal?

# 4. This command’s intent is to query an object from every computer in the domain:
Get-ADComputer –Filter * | Select @{n='ComputerName';e={$_.Name}} | Get-WmiObject –Class Win32_BIOS
# Will the command achieve the goal?

# 5. This command’s intent is to list the services that are running on every computer in the domain:
Get-Service –ComputerName (Get-ADComputer –Filter *)
# Will the command achieve the goal?

# 6. This command’s intent is to list the Security event log entries from the server LON-DC1:
Get-EventLog –LogName Security –ComputerName (Get-ADComputer LON-DC1 | Select –ExpandProperty Name)
# Will the command achieve the goal?

# 7. Note
# 8. Write a command that uses Get-EventLog to display the most recent 50 System event log entries from each computer in the domain.
# 9. Write a command that uses Set-Service to set the start type of the WinRM service to Auto on every computer in the domain. Do not use a parenthetical command.
