Get-Command Get-ADDomainController
$MyDCs = Get-ADDomainController

Get-Command Get-ADComputer
$MyServers = Get-ADComputer -Filter {Operatingsystem -like "*server*"}


New-Item -ItemType File -Path $profile -Force

echo '$MyDCs = Get-ADDomainController' >  $profile
echo '$MyServers = Get-ADComputer -Filter {Operatingsystem -like "*server*"}' >> $profile
cat $profile