#!/bin/bash

# Creating & Assigning tags after ec2 m/c is created

for instance_id in $(aws ec2 describe-instances --query Reservations[].Instances[].InstanceId --output text)
do
    echo "Instance_id - ${instance_id}"
    echo "Applying tags to ${instance_id}"
    aws ec2 create-tags \
        --resources ${instance_id} \
        --tags "Key=Project,Value=qt_workshop" "Key=Env,Value=test" "Key=team,Value=qt_aws" "Key=release,Value=v1.0"
done