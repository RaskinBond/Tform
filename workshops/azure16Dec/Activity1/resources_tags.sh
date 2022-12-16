#!/bin/bash

# tag all the Resources of a Resource group with multiple tags

for resource_ids in $(az resource list --resource-group workshop --output tsv --query "[].id")
do
    echo "Resource id is $resource_ids"
    az tag create --resource-id "$resource_ids" \
        --tags "Environment=Dev" "Project=azurelearning" "Release=v1.1" "Team=qtazure"
done