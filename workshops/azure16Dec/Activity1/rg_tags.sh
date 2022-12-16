#!/bin/bash

# tag all the Resource groups with a single tag

for resource_groups in $(az group list --query "[].id" --output tsv)
do
    echo "Resource Groups id's are $resource_groups"
    az tag create --resource-id $resource_groups --tags "Environment=Dev"
done