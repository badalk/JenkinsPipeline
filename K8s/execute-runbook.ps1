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
    $AutomationAccountName,
    [Parameter(Mandatory=$true)]
    [string]
    $Name,
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroupName
)

Write-Output "ResourceGroupName:$ResourceGroupName"
Write-Output "SubscriptionName:$SubscriptionName"
Write-Output "AutomationAccountName:$AutomationAccountName"
Write-Output "Name:$Name"


$parameter_contents=Get-Content -Path $PARAMETERS_FILE
$user_id=$USER_ID

$webhookdata=[ordered]@{
        RequestBody="$parameter_contents"
    RequestHeader=@{
        Deployer=$user_id}
    WebhookName="Jenkins"}
    if($webhookdata){
        Write-Output $webhookdata | ConvertTo-Json
    }
    if(-Not $webhookdata){
        Write-Output "Check $webhookdata"
    }
    $setSubscription=Select-AzureRmSubscription -SubscriptionName $SubscriptionName
    Write-Output "$setSubscription"
    if($webhookdata){
        write-host $webhookdata.RequestBody
        Start-AzureRmAutomationRunbook -AutomationAccountName $AutomationAccountName -Name $Name -ResourceGroupName $ResourceGroupName -Parameters $webhookdata -MaxWaitSeconds 1000 -Wait
    }
