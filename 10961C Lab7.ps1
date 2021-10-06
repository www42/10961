# 10961 C Module 07
# ==================

# Exercise 1: Working with Variable Types
# ----------------------------------------
# 1. Sign in to LON-CL1
# 2. Open PowerShell
# 3. Create Variable for C:\logs
$logPath = "C:\Logs\"

# 4. Identify Type of Variable and Available Properties
$logPath.GetType()

# 5. Get $logPath Members
$logPath | Get-Member

# 6. Create Variable for log.txt
$logFile = "log.txt"

# 7. Update $logPath to Include $logFile
$logPath += $logFile

# 8. Display Contents of $logPath
$logPath

# 9. Configure $logPath.Replace Variable
$logPath.Replace("C:", "D:")

# 10. Update $logPath to Use Drive D Instead of C
$logPath = $logPath.Replace("C:", "D:")

# 11. Display Contents of $logPath
$logPath

# 12. Create Variable for Today's Date
$today = Get-Date

# 13. Identify Type of Variable and Available Properties
$today.GetType()

# 14. Get $today Members
$today | Get-Member

# 15. Create String in Format Year-Month-Day-Hour-Minute
$logFile = [string]$today.Year + "-" + $today.Month + "-" + $today.Day + "-" + $today.Hour + "-" + $today.Minute + ".txt"

# 16. Create $cutOffDate Variable 30 Days Before Today
$cutOffDate = $today.AddDays(-30)

# 17. Get Accounts That have Signed in since $cutOffDay
Get-ADUser -Properties LastLogonDate -Filter {LastLogonDate -gt $cutOffDate}




# Exercise 2: Using Arrays
# ----------------------------------------
# 1. Add All AD DS Marketing Users into Variable
$mktgUsers = Get-ADUser -Filter {Department -eq "Marketing"} -Properties Department

# 2. Identify Number of Marketing Users
$mktgUsers.Count

# 3. Display First User and Confirm Properties
$mktgUsers[0]

# 4. Update Department to Business Development
$mktgUsers | Set-ADUser -Department "Business Development"

# 5. Check if $mktgUsers Variable Updated
$mktgUsers | Format-Table Name,Department

# 6. Confirm No Users are in Marketing
Get-ADUser -Filter {Department -eq "Marketing"}

# 7. Confirm 52 Users are in Business Development
Get-ADUser -Filter {Department -eq "Business Development"}

# 8. Create Arraylist Named $computers
[System.Collections.ArrayList]$computers = "LON-SRV1", "LON-SRV2", "LON-DC1"

# 9. Confirm $computers Doesn't Have a Fixed Size
$computers.IsFixedSize

# 10. Add LON-DC2 to $computers
$computers.Add("LON-DC2")

# 11. Remove LON-SRV2 from $computers
$computers.Remove("LON-SRV2")

# 12. Display Computers in $computers
$computers





# Exercise 3: Using Hash Tables
# -----------------------------
# 1. Create Hash Table Name $mailList
$mailList = @{"Frank" = "Frank@fabriakm.com"; `
              "Libby" = "LHayward@contso.com"; `
              "Matej" = "MSTaojanov@tailspintoys.com"}

# 2. Display $mailList Contents
$mailList

# 3. Display Email for Libby
$mailList.Libby

# 4. Update Email for Libby
$mailList.Libby = "Libby.Hayward@contoso.com"

# 5. Add New Email for Stela
$mailList.Add("Stela", "Stela.Sahiti")

# 6. Remove Frank From $mailList
$mailList.Remove("Frank")

# 7. Confirm Frank was Removed
$mailList

# 8. Close PowerShell
