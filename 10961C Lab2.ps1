# Exercise 1: Creating and managing Active Directory objects
# ----------------------------------------------------------

# -------
# LON-CL1
# -------

# Create a new organizational unit (OU) for a branch office
New-ADOrganizationalUnit -Name London

# Create group for branch office administrators
New-ADGroup "London Admins" -GroupScope Global

# Create a user and computer account for the branch office
New-ADUser -Name Ty -DisplayName "Ty Carlson"
Add-ADGroupMember “London Admins” -Members Ty
New-ADComputer LON-CL2

# Move the group, user, and computer accounts to the branch office OU
Move-ADObject -Identity "CN=London Admins,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"
Move-ADObject -Identity "CN=Ty,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"
Move-ADObject -Identity "CN=LON-CL2,CN=Computers,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"


# Exercise 2: Configuring network settings on Windows Server
# ----------------------------------------------------------

# --------
# LON-SVR1
# --------

# Test the network connection and view the configuration
Test-Connection LON-DC1
Get-NetIPConfiguration

# Change the server IP address
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.15 -PrefixLength 16
Remove-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.11 -Confirm:$false

# Change the DNS settings and default gateway for the server
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddress 172.16.0.12
Remove-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -Confirm:$false
New-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -NextHop 172.16.0.2

# Verify and test the changes
Get-NetIPConfiguration


# Exercise 3: Creating a website
# ------------------------------

# --------
# LON-SVR1
# --------

# Install IIS on the server 
Install-WindowsFeature Web-Server

# Create a folder on the server for the website
New-Item C:\inetpub\wwwroot\London -Type directory

# Create a new application pool for the website
New-WebAppPool LondonAppPool

# Create the IIS website
New-WebSite London -PhysicalPath C:\inetpub\wwwroot\london -IPaddress 172.16.0.15 -ApplicationPool LondonAppPool

# On the taskbar, click the Internet Explorer icon. 
# In the Address bar, type 172.16.0.15, and then press Enter.