# 10961C Lab 1B Finding and running basic commands
# ------------------------------------------------

# Exercise 1: Finding commands
# ----------------------------

Get-Command *resolve*
Resolve-DnsName google.com

Get-Command *adapter*
Get-NetAdapter
Get-Command -Noun NetAdapter
Get-Help Set-NetAdapter
Get-Help Set-NetAdapter -Parameter MacAddress

Get-Command *sched*
Get-ScheduledTask

Get-Command *block*
Get-Help Block-SmbShareAccess

Get-Command *branch*
# nothing

Get-Command *cache*
Get-Command -Verb clear
Clear-DnsClientCache

Get-Command *firewall*
Get-NetFirewallRule

Get-Command *address*
Get-NetIPAddress

Get-Command -Verb suspend

Get-Command -Noun content


# Exercise 2: Runnning commands
# -----------------------------

Get-NetFirewallRule -Enabled True
Get-NetIPAddress -AddressFamily IPv4
Set-Service -Name BITS -StartupType Automatic
Test-NetConnection LON-DC1 -InformationLevel Quiet
Get-EventLog -LogName Security -Newest 10


# Exercise 3: Using about files
# -----------------------------

Get-Help *comparison*
Get-Help about_comparison_operators -ShowWindow

$env:COMPUTERNAME
Get-Help about_environment_variables

Get-Help *signing*
Get-Help about_signing