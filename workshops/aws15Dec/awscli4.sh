#!/bin/bash

# Manage lifecycle of ec2 instance based on tag

for instance_id in $(aws ec2 describe-instances --filters "Name=tag:Env,Values=test" --query "Reservations[].Instances[].InstanceId" --output text)
do
    echo "stopping instance with instance id ${instance_id}"
    aws ec2 stop-instances --instance-ids ${instance_id}
    sleep 5s
    current_state=$(aws ec2 describe-instances --instance-ids ${instance_id} --query "Reservations[].Instances[].State.Name|[0]" --output text)
    echo "The current state is ${current_state} for ec2 instance with id ${instance_id}"
done