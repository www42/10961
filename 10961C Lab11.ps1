# 10961 C Module 11
# ==================

# Exercise 1: Starting and Managing Jobs
# --------------------------------------
# 1. Sign in to LON-CL1
# 2. Open PowerShell as Administrator
# 3. List Physical Network Adapter on Other Machines
Invoke-Command { Get-NetAdapter –Physical } –ComputerName LON-DC1, LON-SVR1 –AsJob –JobName RemoteNetAdapt

# 4. List SMB Shares
Invoke-Command { Get-SMBShare } –ComputerName LON-DC1,LON-SVR1 –AsJob –JobName RemoteShares

# 5. Retrieve All Instances of Win32_Volume Class
Invoke-Command { Get-CimInstance –ClassName Win32_Volume } –ComputerName (Get-ADComputer –Filter * | Select –Expand Name) –AsJob –JobName RemoteDisks

# 6. List All Entries from Local Security Event Log
Start-Job { Get-EventLog –LogName Security } –Name LocalSecurity

# 7. Produce 100 Directory Listings
Start-Job { 1..100 | ForEach-Object { Dir C:\ -Recurse } } –Name LocalDir

# 8. List Running Jobs
Get-Job

# 9. List Running Jobs Starting with Remote
Get-Job –Name Remote*

# 10. Stop LocalDir Job
Stop-Job –Name LocalDir

# 11. Wait Till Jobs Stop Running
Get-Job  # Wait until no jobs have a status of Running

# 12. Receive Results of RemoteNetAdapt Job
Receive-Job –Name RemoteNetAdapt

# 13. Receive Results of RemoteDisks Job
Get-Job –Name RemoteDisks –IncludeChildJob | Receive-Job   # LON-CL1 failed because PSRemoting is not enabled on LON-CL1





# Exercise 2: Creating a Scheduled Job
# ------------------------------------
# 1. Create Job Option
$option = New-ScheduledJobOption –WakeToRun -RunElevated

# 2. Create Job Trigger
$trigger1 = New-JobTrigger –Once –At (Get-Date).AddMinutes(5)

# 3. Register the Job
Register-ScheduledJob –ScheduledJobOption $option –Trigger $trigger1 –ScriptBlock { Get-EventLog –LogName Security } –MaxResultCount 5 –Name LocalSecurityLog

# 4. List Job Triggers
Get-ScheduledJob –Name LocalSecurityLog | Select –Expand JobTriggers

# 5. List Jobs
Get-Job

# 6. Receive Job Results
Receive-Job –Name LocalSecurityLog

#  7. Switch to LON-DC1
#  8. Activate Windows Sign In
#  9. Sign in to LON-DC1
# 10. Open Active Directory Users and Computers
# 11. Disable Account in Managers
# 12. Open Task Scheduler
# 13. Begin Creating Task
# 14. Configure Settings on General Tab
# 15. Configure Trigger
# 16. Configure Action
# 17. View Conditions
# 18. Select Other Settings
# 19. Enter Password
# 20. Wait for Job to Run
# 21. View Disabled User
