#!/bin/bash

# Creating ec2-instance from aws_cli for Oregon region
aws ec2 run-instances \
     --image-id ami-0530ca8899fac469f \
     --instance-type t2.micro \
     --key-name "microsoft"