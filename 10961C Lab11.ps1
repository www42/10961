# 10961C Lab 11: Using background jobs and scheduled jobs
# -------------------------------------------------------

# LON-CL1
# -------

#region Exercise 1: Starting and Managing Jobs
Invoke-Command { Get-NetAdapter –Physical } –ComputerName LON-DC1, LON-SVR1 –AsJob –JobName RemoteNetAdapt

#endregion
