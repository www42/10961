# 10961C Lab 7 Working with variables, arrays, and hash tables

#region Working with variables

$logPath = "C:\Logs\"
$logPath.GetType()
$logPath | Get-Member
$logFile = "log.txt"
$logPath += $logFile
$logPath
$logPath.Replace("C:", "D:")
$logPath = $logPath.Replace("C:", "D:")
$logPath

$today = Get-Date
$today.GetType()
$today | Get-Member
$logFile = [string]$today.Year + "-" + $today.Month + "-" + $today.Day + "-" + $today.Hour + "-" + $today.Minute + ".txt"
$cutOffDate = $today.AddDays(-30)
Get-ADUser -Properties LastLogonDate -Filter {LastLogonDate -gt $cutOffDate}

#endregion

#region Using Arrays

$mktgUsers = Get-ADUser -Filter {Department -eq "Marketing"} -Properties Department
$mktgUsers.Count                                            # 52
$mktgUsers[0]                                               # Lizzie Terrell
$mktgUsers | Set-ADUser -Department "Business Development"
$mktgUsers | Format-Table Name,Department
Get-ADUser -Filter {Department -eq "Marketing"}             # Niemand mehr
Get-ADUser -Filter {Department -eq "Business Development"}  # die 52

[System.Collections.ArrayList]$computers = "LON-SRV1", "LON-SRV2", "LON-DC1"
$computers.IsFixedSize
$computers.Add("LON-DC2")
$computers.Remove("LON-SRV2")
$computers

#endregion

#region Using Hash Tables
$mailList = @{"Frank" = "Frank@fabriakm.com"; `
              "Libby" = "LHayward@contso.com"; `
              "Matej" = "MSTaojanov@tailspintoys.com"}

$mailList
$mailList.Libby
$mailList.Libby = "Libby.Hayward@contoso.com"
$mailList.Add("Stela", "Stela.Sahiti")
$mailList.Remove("Frank")
$mailList

#endregion