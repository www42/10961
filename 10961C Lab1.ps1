# 10961 C Module 01
# ==================

# ------------------------------------
# Lab A Configuring Windows PowerShell
# ------------------------------------

# Exercise 1: Configuring the Windows PowerShell Console Application
# ------------------------------------------------------------------
#  1. Sign in to LON-CL1
#  2. Open PowerShell as Administartor
#  3. Confirm Version of PowerShell that Opens
#  4. Pin PowerShell to Taskbar
#  5. Open PowerShell Properties
#  6. Change Font and Text Size
#  7. View Colors Tab
#  8. Adjust Window Size
#  9. Adjust Screen Buffer Size
# 10. Start Shell Transcript
Start-Transcript C:\DayOne.txt
Stop-Transcript
Get-Content C:\DayOne.txt



# Exercise 2: Configuring the Windows PowerShell ISE Application
# --------------------------------------------------------------
# 1. Open PowerShell ISE
# 2. Close ISE Window
# 3. Open PowerShell ISE as Administrator
# 4. Display Script Pane
# 5. Show Commands Pane
# 6. Hide Command Pane
# 7. Adjust Font Size
# 8. Close PowerShell ISE




# ----------------------------------------
# Lab B Finding and running basic commands
# ----------------------------------------

# Exercise 1: Finding commands
# ----------------------------
# 1. Open PowerShell as Administrator
# 2. Get Commands Containing 'Resolve'
Get-Help *resolve*
Get-Command *resolve*
Resolve-DnsName google.com

# 3. List Commands Containing 'Adapter'
Get-Help *adapter*
Get-Command *adapter*
Get-Command -Noun *adapter*
Get-Command -Verb Set -Noun *adapter*
Get-NetAdapter

# 4. View Help for Set-NetAdapter
Get-Help Set-NetAdapter
Get-Help Set-NetAdapter -Parameter MacAddress

# 5. List Commands Containing 'sched'
Get-Help *sched*
Get-Command *sched*
Get-Module *sched* -ListAvailable

# 6. List Commands Containing 'Block'
Get-Command *block*
Get-Help Block-SmbShareAccess

# 7. List Topics Containing 'Branch'
Get-Help *branch*

# 8. List Commands Containing 'Cache'
Get-Command *cache*
Get-Command -Verb clear
Get-Command Clear-BCCache

# 9. List Commands Containing 'Firewall'
Get-Command *firewall*
Get-Help *rule*
Get-Command *rule*
Get-Command Get-NetFirewallRule

# 10. Display Help for Get-NetFirewallRule
Get-Help Get-NetFirewallRule –Full

# 11. List Commands Containing 'Address'
Get-Help *address*
Get-Command Get-NetIPAddress

# 12. List Commands Containing 'Suspend'
Get-Command -Verb suspend

# 13. Get Definition or List Commands Containing 'Type'
Get-Command -Noun *content*
Get-Command Get-Content




# Exercise 2: Runnning commands
# -----------------------------
# 1. List Enabled Firewall Rules
Get-NetFirewallRule -Enabled True

# 2. List All Local IPv4 Addresses
Get-NetIPAddress -AddressFamily IPv4

# 3. Set BITS Startup Type
Set-Service -Name BITS -StartupType Automatic

# 4. Test Connection to LON-DC1
Test-NetConnection LON-DC1 -InformationLevel Quiet

# 5. Display Newest 10 Entries in Security Event Log
Get-EventLog -LogName Security -Newest 10




# Exercise 3: Using about files
# -----------------------------
# 1. Get Commands Containing 'comparison'
Get-Help *comparison*

# 2. Open about_comparison_operators
Get-Help about_comparison_operators -ShowWindow

# 3. Search for Wildcard
# 4. Read about_Comparison_Operators
# 5. Display Computer Name
$env:COMPUTERNAME
Get-Help about_environment_variables

# 6. List Commands Containing Signing
Get-Help *signing*

# 7. Show about_signing Help File
Get-Help about_signing

# 8. Read about_signing
