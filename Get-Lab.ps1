function Get-Lab {
    [CmdletBinding()]
    Param ( [Parameter(Mandatory=$true, Position=0)]
      [string]$Lab
    )
    $Url = "https://raw.githubusercontent.com/www42/10961/master/10961C%20Lab$Lab.ps1"
    $File = "$env:TEMP\Lab$Lab.ps1"
    iwr -UseBasicParsing -Uri $Url | % Content > $File
    psEdit $File

    iwr -Uri https://download.sysinternals.com/files/ZoomIt.zip -OutFile "$env:TEMP\zoomit.zip"
    Expand-Archive -Path "$env:TEMP\zoomit.zip" -DestinationPath C:\windows\System32
}
Get-Lab
zoomit64
