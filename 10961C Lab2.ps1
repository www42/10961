# Exercise 1: Creating and managing Active Directory objects
# ----------------------------------------------------------

# 1. Sign in to LON-CL1
# 2. Open PowerShell as Administrator
# 3. Create OU Named London
New-ADOrganizationalUnit -Name London

# 4. Create Group Named London Admins
New-ADGroup -Name "London Admins" -GroupScope Global

# 5. Create User
New-ADUser -Name Ty -DisplayName "Ty Carlson"

# 6. Add User to London Admins
Add-ADGroupMember -Identity "London Admins" -Members Ty

# 7. Add Computer to AD
New-ADComputer -Name LON-CL2

# 8. Move London Admins to London OU
Move-ADObject -Identity "CN=London Admins,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"

# 9. Move Ty to London OU
Move-ADObject -Identity "CN=Ty,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"

# 10. Move LON-CL2 to London OU
Move-ADObject -Identity "CN=LON-CL2,CN=Computers,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"




# Exercise 2: Configuring network settings on Windows Server
# ----------------------------------------------------------

# 1. Switch to LON-SVR1
# 2. Activate Windows Sign In
# 3. Sign in to LON-SVR1
# 4. Open PowerShell as Administrator
# 5. Test Connection to LON-DC1
Test-Connection LON-DC1

# 6. Get IP Configuration
Get-NetIPConfiguration

# 7. Add New IP Address
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.15 -PrefixLength 16

# 8. Remove Old IP Address
Remove-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.11 -Confirm:$false

# 9. Set DNS Server Address
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddress 172.16.0.12

# 10. Remove IP Route
Remove-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -Confirm:$false

# 11. Create IP Route
New-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -NextHop 172.16.0.2

# 12. Get IP Configuration
Get-NetIPConfiguration

# 13. Test Connection to LON-DC1
Test-Connection LON-DC1




# Exercise 3: Creating a website
# ------------------------------

# 1. Install IIS on LON-SVR1
Install-WindowsFeature Web-Server

# 2. Create Folder for Website Files
New-Item C:\inetpub\wwwroot\London -Type directory

# 3. Create Application Pool
New-WebAppPool LondonAppPool

# 4. Create IIS Website
New-WebSite London -PhysicalPath C:\inetpub\wwwroot\london -IPaddress 172.16.0.15 -ApplicationPool LondonAppPool

# 5. Open Internet Explorer
# 6. Browse to IIS Site