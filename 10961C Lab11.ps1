# 10961C Lab 11: Using background jobs and scheduled jobs
# -------------------------------------------------------

#region Exercise 1: Starting and Managing Jobs
# LON-CL1
# -------
Invoke-Command { Get-NetAdapter –Physical } –ComputerName LON-DC1, LON-SVR1 –AsJob –JobName RemoteNetAdapt
Invoke-Command { Get-SMBShare } –ComputerName LON-DC1,LON-SVR1 –AsJob –JobName RemoteShares
Invoke-Command { Get-CimInstance –ClassName Win32_Volume } –ComputerName (Get-ADComputer –Filter * | Select –Expand Name) –AsJob –JobName RemoteDisks
Start-Job { Get-EventLog –LogName Security } –Name LocalSecurity
Start-Job –ScriptBlock { 1..100 | ForEach-Object { Dir C:\ -Recurse } } –Name LocalDir
Get-Job
Get-Job –Name Remote*
Stop-Job –Name LocalDir
Get-Job  # Wait until no jobs have a status of Running
Receive-Job –Name RemoteNetAdapt
Get-Job –Name RemoteDisks –IncludeChildJob | Receive-Job   # LON-CL1 failed because PSRemoting is not enabled on LON-CL1

#endregion


#region Exercise 2: Creating a Scheduled Job
# LON-CL1
# -------
$option = New-ScheduledJobOption –WakeToRun -RunElevated
$trigger1 = New-JobTrigger –Once –At (Get-Date).AddMinutes(5)
Register-ScheduledJob –ScheduledJobOption $option –Trigger $trigger1 –ScriptBlock { Get-EventLog –LogName Security } –MaxResultCount 5 –Name LocalSecurityLog
Get-ScheduledJob –Name LocalSecurityLog | Select –Expand JobTriggers
Get-Job
Receive-Job –Name LocalSecurityLog

# LON-DC1
# -------
# E:\Labfiles\Mod11\DeleteDisabledUserManagersGroup.ps1  is the action of a scheduled task created in GUI

#endregion