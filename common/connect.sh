#!/bin/bash

set -e


LIST=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0],State.Name,PrivateIpAddress,PublicIpAddress]' --output text | column -t)
DEETS=$(echo "$LIST" | grep $1 | grep running)

INSTANCE_NAME=$(echo "$DEETS" | awk '{print $2;}' | uniq | head -n 1)
[[ $INSTANCE_NAME == *$'\n'* ]] && echo "multiple instances found for $1..." && echo "$INSTANCE_NAME" && false

IP=$(echo "$DEETS" | awk 'NR==1{print $5}')


echo $INSTANCE_NAME

if [ -z $2 ]; then
  ssh ec2-user@$IP
else
  CMD=$2
  DOCKER_RUN="sudo docker exec -it \$(sudo docker ps | grep dockerrun.sh | awk '{print \$1}')"
  FULL_CMD="$DOCKER_RUN $CMD"
  case "$CMD" in
    "c")
      FULL_CMD="$DOCKER_RUN rails c";;
    "db")
      FULL_CMD="$DOCKER_RUN rails db";;
    "logs")
      FULL_CMD="sudo docker logs --tail=2000 -f \$(sudo docker ps | grep dockerrun.sh | awk '{print \$1}')";;
  esac
  echo "ssh -t ec2-user@$IP $FULL_CMD"
  ssh -t ec2-user@$IP $FULL_CMD
fi

