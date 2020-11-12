# 10961C Lab 9 Advanced Scripting

# Lab A: Accepting data from users
# ---------------------------------

#region Exercise 1
# QueryDisk.ps1
# -------------
param(
    [string]$ComputerName=(Read-Host "Enter computer name")
    )
    
    Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
    
#endregion
    
#region Exercise 2
# QueryDisk.ps1
# -------------
param(
    [string]$ComputerName=(Read-Host "Enter computer name"),
    [switch]$AlternateCredential
)

If ($AlternateCredential -eq $true) {
    $cred = Get-Credential
    $session = New-CimSession -ComputerName $ComputerName -Credential $cred
    Get-CimInstance Win32_LogicalDisk -CimSession $session -Filter "DriveType=3"
} Else {
    Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
}

#endregion

#region Exercise 3
# QueryDisk.ps1
# -------------
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


#endregion


# Lab B: Implementing functions and modules
# -----------------------------------------

#region Exercise 1
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

 Write-Log -Folder E:\Mod09\Labfiles\ -File TestLog.txt -Data "Test log data"

 #endregion