#!/bin/bash

# Deleting Resource group by some specific tag

for rg_name in $(az group list --query "[].name" --tag "Environment=Dev" --output tsv)
do
    echo "Deleting Resource group"
    az group delete --name ${rg_name}
done