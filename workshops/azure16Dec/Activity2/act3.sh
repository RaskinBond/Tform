#!/bin/bash

# todo handle different resource types

resource_type="Microsoft.Compute/VirtualMachines"
tag_name=$1
tag_value=$2

for vm_id in $(az resource list --resource-type "${resource_type}" --query "[?tags.${tag_name}=='${tag_value}'].id" --output tsv)
do
    echo "Deallocating vm's with id ${vm_id}"
    az vm deallocate  --ids ${vm_id}
done