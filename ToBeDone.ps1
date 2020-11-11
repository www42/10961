
New-AzResourceGroup -Name $rgName -Location $location
Get-AzResourceGroup | Format-Table ResourceGroupName,Location,ProvisioningState

New-AzVm `
    -Name $vmName `
    -ResourceGroupName $rgName `
    -Location $location `
    -VirtualNetworkName $vnetName `
    -SubnetName $subnetName `
    -Credential $credential `
    -SecurityGroupName $nsgName `
    -PublicIpAddressName $pipName `
    -OpenPorts 80,3389


Get-AzVM
Get-AzVM -Status | Format-Table Name,ResourceGroupName,Location,PowerState

Get-AzResource -ResourceGroupName $rgName | Format-Table Name,ResourceType
