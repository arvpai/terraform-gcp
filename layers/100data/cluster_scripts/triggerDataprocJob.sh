#!/bin/bash

REGION="europe-west2"

PROJECT=$(gcloud info --format='value(config.project)')
FULL_NAME=`gcloud config get-value account`
IFS='@'
read -ra ADDR <<< "$FULL_NAME"
USER_NAME=${ADDR[0]}

if [ ! -z $1 ]; then
  JOB_LOCATION=$1
fi

if [ ! -z $2 ]; then
  PARAMETERS=$2
fi

if [ ! -z $3 ]; then
  REGION=$3
fi

gcloud dataproc jobs submit spark \
  --region ${REGION} \
  --cluster ${PROJECT}-${USER_NAME}-cluster \
  --jar ${JOB_LOCATION} \
  --jars "gs://spark-lib/bigquery/spark-bigquery-latest.jar" \
  -- ${PARAMETERS}
