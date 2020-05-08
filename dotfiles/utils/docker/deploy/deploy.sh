#!/bin/bash
set -e
docker pull <image>:<tag>
sleep 5
docker stop <service_name>
do-clear #custom script to delete non-running containers
docker run -d --name <name> -p1234:1234 <image>/<tag>
