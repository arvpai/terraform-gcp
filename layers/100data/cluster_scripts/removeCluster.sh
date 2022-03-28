#!/bin/bash
REGION="europe-west2"

PROJECT=$(gcloud info --format='value(config.project)')
FULL_NAME=`gcloud config get-value account`
IFS='@' # space is set as delimiter
read -ra ADDR <<< "$FULL_NAME" # str is read into an array as tokens separated by IFS
USER_NAME=${ADDR[0]}

echo "Y" | gcloud dataproc clusters delete ${PROJECT}-${USER_NAME}-cluster --region ${REGION}
