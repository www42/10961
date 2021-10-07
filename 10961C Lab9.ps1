# 10961 C Module 09
# ==================

# ---------------------------------
# Lab A: Accepting data from users
# ---------------------------------

# Exercise 1: Querying Disk Information from Remote Computers
# -----------------------------------------------------------
# 1. Sign in to LON-CL1
# 2. Note About this Exercise
# 3. Find cmdlet to Remote Query Hardware Information
# 4. Find Syntax to Query Logical Disk Information
# 5. Create Script Named QueryDisk.ps1
New-Item -ItemType File -Path E:\Mod09\QueryDisk.ps1
psEdit E:\Mod09\QueryDisk.ps1

# 6. Add Parameter for Computer Name
param(
    [string]$ComputerName=(Read-Host "Enter computer name")
    )
    
Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
    
# 7. Confirm Script Queries Disk Information
E:\Mod09\QueryDisk.ps1
  


# Exercise 2: Updating the Script to Use Alternate Credentials
# ------------------------------------------------------------
# 1. Note About this Exercise
# 2. Update param() to Use Alternate Credentials
param(
    [string]$ComputerName=(Read-Host "Enter computer name"),
    [switch]$AlternateCredential
)

# 3. Add If Statement that Evaluates the Switch
If ($AlternateCredential -eq $true) {
    $cred = Get-Credential
    $session = New-CimSession -ComputerName $ComputerName -Credential $cred
    Get-CimInstance Win32_LogicalDisk -CimSession $session -Filter "DriveType=3"
} Else {
    Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
}


# Exercise 3: Documenting a Script
# --------------------------------
# 1. Note About this Exercise
# 2. Add Comments to Code
<#
.SYNOPSIS
This script queries hard drive information from remote computers.

.DESCRIPTION
This script queries hard drive information from remote computers by using WS-MAN. 
WS-MAN needs to be configured on remote computers. This is done by default on
Windows Server 2012 and newer.

.PARAMETER ComputerName
Used to specify the name of the remote computer,

.PARAMETER AlternateCredential
Used to specify that alternate credentials are required.

.EXAMPLE
.\QueryDisk -ComputerName LON-DC1

.EXAMPLE
.\QueryDisk -ComputerName LON-DC1 -AlternateCredential
#>

param(
    #If users do not specify a computer name, they are prompted for one
    [string]$ComputerName=(Read-Host "Enter computer name"),
    [switch]$AlternateCredential
)

#If statement identifies whether the -AlternateCredential parameter was used.
If ($AlternateCredential -eq $true) {
    $cred = Get-Credential
    #A session is required because Get-CimInstance does not have
    #a parameter to specify alternate credentials
    $session = New-CimSession -ComputerName $ComputerName -Credential $cred
    Get-CimInstance Win32_LogicalDisk -CimSession $session -Filter "DriveType=3"
} Else {
    Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
} #EndIf

# 3. Confirm You Can Query Help Information
Get-Help E:\Mod09\QueryDisk.ps1




# -----------------------------------------
# Lab B: Implementing functions and modules
# -----------------------------------------

# Exercise 1: Creating a Logging Function
# ---------------------------------------
# 1. Note About this Exercise
# 2. Create Script Named LogFunction.ps1
New-Item -ItemType File -Path E:\Mod09\LogFunction.ps1
psEdit E:\Mod09\LogFunction.ps1

# 3. Create Function Named Write-Log
function Write-Log {}

# 4. Create Param() for Folder, File Name and Data
function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )
}

# 5. Create Variable for Log File Path
function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )

    #Calculate full path for log files
    $logPath = $folder + $file
}

# 6. Calculate Timestamp
function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )

    #Calculate full path for log files
    $logPath = $folder + $file
    
    #Calculate time stamp for log entry
    $date = get-date
    $timeStamp = $date.ToShortDateString() + " " + $date.ToLongTimeString() + ": "
 
}

# 7. Send Timestamp and Data to the File
function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )

    #Calculate full path for log files
    $logPath = $folder + $file
    
    #Calculate time stamp for log entry
    $date = get-date
    $timeStamp = $date.ToShortDateString() + " " + $date.ToLongTimeString() + ": "
    
    #Write data to log file
    $timeStamp + $data | Out-File $logPath -Append

}

# 8. Add Line to Call for Function and Test Script
Write-Log -Folder E:\Mod09\Labfiles\ -File TestLog.txt -Data "Test log data"



# Exercise 2: Adding Error Handling to a Script
# ---------------------------------------------
# 1. Note About this Exercise
# 2. Add Test to Identify if Folder Ends with Backslash

function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )

    #Add a backslash to the folder if it is missing
    $endBackslash = $Folder.EndsWith("\")
    If ($endBackslash -eq $false) {
        $Folder += "\"
    }

    #Calculate full path for log files
    $logPath = $folder + $file
    
    #Calculate time stamp for log entry
    $date = get-date
    $timeStamp = $date.ToShortDateString() + " " + $date.ToLongTimeString() + ": "
    
    #Write data to log file
    $timeStamp + $data | Out-File $logPath -Append

}

# 3. Add Try..Catch to Provide Friendly Error Message
function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )

    #Add a backslash to the folder if it is missing
    $endBackslash = $Folder.EndsWith("\")
    If ($endBackslash -eq $false) {
        $Folder += "\"
    }

    #Calculate full path for log files
    $logPath = $folder + $file
    
    #Calculate time stamp for log entry
    $date = get-date
    $timeStamp = $date.ToShortDateString() + " " + $date.ToLongTimeString() + ": "
    
    #Write data to log file
    Try {
        $timeStamp + $data | Out-File $logPath -Append -ErrorAction Stop
    } Catch {
        Write-Host "Error writing to log file $logPath"
    } 
}

# 4. Confirm Error Message Appears
Write-Log -Folder E:\Mod090\Labfiles\ -File TestLog.txt -Data "Test log data"



# Exercise 3: Converting a Function to a Module
# ---------------------------------------------
# 1. Remove Line that Calls the Function
# 2. Begin Saving Script in New Folder
# 3. Save File as LogFunction.psm1
'C:\Program Files\WindowsPowerShell\Modules\LogFunction\LogFunction.psm1'

# 4. Confirm Function Loads Properly
Write-Log
