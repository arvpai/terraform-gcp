#!/bin/bash

REGION="europe-west2"

PROJECT=$(gcloud info --format='value(config.project)')
FULL_NAME=`gcloud config get-value account`
IFS='@'
read -ra ADDR <<< "$FULL_NAME"
USER_NAME=${ADDR[0]}

if [ ! -z $1 ]; then
  HQL_TO_EXECUTE=$1
fi

IFS=',' read -ra HQL_SPLIT <<< "$HQL_TO_EXECUTE"
for file in "${HQL_SPLIT[@]}"; do
  gcloud dataproc jobs submit hive \
      --cluster ${PROJECT}-${USER_NAME}-cluster \
      --region ${REGION} \
      --file ${file}
done
