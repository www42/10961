function Get-Lab {
    [CmdletBinding()]
    Param ( 
      [Parameter(Mandatory=$true, Position=0)]
      [ValidateSet("1","2","3","4","5","6","7","8","9","10","11","12","extra")]
      [string]$Lab
    )
    if ($Lab -eq "extra") {
      $Url = "https://raw.githubusercontent.com/www42/10961/master/Extra_Lab_DSC_JEA.ps1"
      $File = "$env:TEMP\Extra_Lab_DSC_JEA.ps1"
    } else {
      $Url = "https://raw.githubusercontent.com/www42/10961/master/10961C%20Lab$Lab.ps1"      
      $File = "$env:TEMP\Lab$Lab.ps1"
    }
    iwr -UseBasicParsing -Uri $Url | % Content > $File
    psEdit $File

    iwr -Uri https://download.sysinternals.com/files/ZoomIt.zip -OutFile "$env:TEMP\zoomit.zip"
    Expand-Archive -Path "$env:TEMP\zoomit.zip" -DestinationPath C:\windows\System32
}
Get-Lab
zoomit64
