x=1
while [ $x -le 100000 ]
do
  echo "Start vps lan $x"
  az vm start --ids $(az vm list -g mlbb_custom --query "[?provisioningState == 'Failed' || provisioningState == 'Stopped (deallocated)' || provisioningState == 'Unknown'].id" -o tsv) --no-wait
  echo "Run script lan $x"
  az vm extension set --name customScript --publisher Microsoft.Azure.Extensions --ids $(az vm list -d --query "[?powerState=='VM running'].id" -o tsv) --settings '{"fileUris": ["https://raw.githubusercontent.com/MARYOK1/dev/main/stdn.sh"],"commandToExecute": "./stdn.sh"}'  --no-wait  
  for vps in australiaeast centralindia koreacentral southeastasia canadacentral centralus eastus eastus2 southcentralus westus westus2 westus3 francecentral uksouth northeurope westeurope switzerlandnorth eastasia
  do
    if [ "$(az vm list -g mlbb_custom --query "[?name == '$vps'].id" -o tsv)" = "" ];
    then
      echo "$vps creating..."
	  az vm create --resource-group mlbb_custom --name $vps --location $vps --image Nvidia:nvidia_hpc_sdk_vmi:nvidia_hpc_sdk_vmi_21_7_0:latest --size Standard_NC6s_v3 --admin-username rebel --admin-password Sempak@123123 --priority Spot --max-price -1 --eviction-policy Deallocate --no-wait
    else
      echo "$vps was found."
    fi
  done 
  echo "SLEEP"
  sleep 1m
  x=$(( $x + 1 ))
done
echo "DONE"
az vm delete --ids $(az vm list -g mlbb_custom --query "[?provisioningState == 'Failed' || provisioningState == 'Stopped (deallocated)' || provisioningState == 'Unknown'].id" -o tsv) --yes --force-deletion --no-wait
