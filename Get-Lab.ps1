function Get-Lab {
    [CmdletBinding()]
    Param ( [Parameter(Mandatory=$true, Position=0)]
      [string]$Lab
    )
    Set-WinUserLanguageList de-de -Force
    $Url = "https://raw.githubusercontent.com/www42/10961/master/10961C%20Lab$Lab.ps1"
    $File = "$env:TEMP\Lab$Lab.ps1"
    
    Invoke-WebRequest -UseBasicParsing -Uri $Url | % Content > $File
    psEdit $File
}