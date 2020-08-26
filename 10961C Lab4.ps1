# Funktioniert der Befehl?
# ------------------------

# 2.
Get-ADComputer -Filter * | Get-Service -Name *
# --> Nein 

# 3.
Get-ADComputer -Filter * | Select-Object @{n='ComputerName';e={$_.Name}} | Get-Service -Name *
# --> Ja (ByPropertyName)

# 4.
Get-ADComputer –Filter * | Select @{n='ComputerName';e={$_.Name}} | Get-WmiObject –Class Win32_BIOS
# --> Nein

# 5.
Get-Service –ComputerName (Get-ADComputer –Filter *)
# --> Nein

# 6.
Get-EventLog –LogName Security –ComputerName (Get-ADComputer LON-DC1 | Select –ExpandProperty Name)
# --> Yes
