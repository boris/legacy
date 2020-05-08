#!/bin/bash

cluster=$1
service=$2
count=$3
limit_up=4
limit_down=1

if [ $count -lt $limit_down ]; then
    echo "limit down exceeded"
    exit 1
elif [ $count -gt $limit_up ]; then
    echo "limit up exceeded"
    exit 1
else
    aws ecs update-service --cluster $cluster --service $service --desired-count $count
fi
