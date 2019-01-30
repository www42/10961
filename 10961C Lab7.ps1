# 10961C Lab 7 Working with variables, arrays, and hash tables

#region Working with variables

$logPath = "C:\Logs\"
$logPath.GetType()
$logPath | Get-Member
$logFile = "log.txt"
$logPath += $logFile
$logPath
$logPath.Replace("C:","D:")
$today = Get-Date
$today.GetType()
$today | Get-Member
$logFile = [string]$today.Year + "-" + $today.Month + "-" + $today.Day + "-" + $today.Hour + "-" + $today.Minute + ".txt"
$cutOffDate = $today.AddDays(-30)

Get-ADUser -Properties LastLogonDate -Filter {LastLogonDate -gt $cutOffDate}

#endregion

#region Arrays

$mktgUsers = Get-ADUser -Filter {Department -eq "Marketing"} -Properties Department
$mktgUsers.Count
$mktgUsers | Set-ADUser -Department "Business Development"

Get-ADUser -Filter {Department -eq "Marketing"}
Get-ADUser -Filter {Department -eq "Business Development"}

#endregion