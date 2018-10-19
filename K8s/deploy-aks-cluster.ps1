param
(
    [Parameter (Mandatory = $true)]
    [String] 
    $PARAMETERS_FILE,
    [Parameter(Mandatory=$true)]
    [string]
    $USER_ID,
    [Parameter(Mandatory=$true)]
    [string]
    $SubscriptionName,
    [Parameter(Mandatory=$true)]
    [string]
    $Name,
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroupName
)

New-AzureRmResourceGroupDeployment -Name ((Get-ChildItem .\\AzureResourceGroup1\\rg-AKS\\azuredeploy-aks.json).BaseName + "-" + ((Get-Date).ToUniversalTime()).ToString("MMdd-HHmm")) `
                                    -ResourceGroupName $ResourceGroupName `
                                    -TemplateFile .\\AzureResourceGroup1\\rg-AKS\\azuredeploy-aks.json 
                                    -TemplateParameterFile $PARAMETERS_FILE 
                                    -Mode Incremental 
                                    -Force 
                                    -Verbose 
                                    -ErrorVariable ErrorMessages

# New-AzureRmResourceGroupDeployment -Name ((Get-ChildItem .\\AzureResourceGroup1\\rg-AKS\\azuredeploy-aks.json).BaseName + "-" + ((Get-Date).ToUniversalTime()).ToString("MMdd-HHmm")) `
#                                     -ResourceGroupName ${parameters.$ResourceGroupNameGroup} `
#                                     -TemplateFile .\\AzureResourceGroup1\\rg-AKS\\azuredeploy-aks.json 
#                                     -TemplateParameterFile .\\AzureResourceGroup1\\rg-AKS\\azuredeploy-aks-cicd.parameters.json 
#                                     -Mode Incremental 
#                                     -Force 
#                                     -Verbose 
#                                     -ErrorVariable ErrorMessages                                    