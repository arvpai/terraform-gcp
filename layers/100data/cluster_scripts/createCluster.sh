#!/bin/bash

REGION="europe-west2"

PROJECT=$(gcloud info --format='value(config.project)')
FULL_NAME=`gcloud config get-value account`
IFS='@' # space is set as delimiter
read -ra ADDR <<< "$FULL_NAME" # str is read into an array as tokens separated by IFS
USER_NAME=${ADDR[0]}

MACHINE_TYPE="n1-standard-4"
DISK_SIZE=30
NUM_WORKERS=3

DATAWAREHOSE_DIR="data-asset-europe-west2-datalake"

if [ ! -z $1 ]; then
  REGION=$1
fi
ZONE="${REGION}-a"

if [ ! -z $2 ]; then
  MACHINE_TYPE=$2
fi

if [ ! -z $3 ]; then
  DISK_SIZE=$3
fi

if [ ! -z $4 ]; then
  NUM_WORKERS=$4
fi


gcloud dataproc clusters create ${PROJECT}-${USER_NAME}-cluster \
  --region ${REGION} \
  --subnet data-asset-europe-west2-private-subnet-1 \
  --zone ${ZONE} \
  --bucket ${DATAWAREHOSE_DIR} \
  --master-machine-type ${MACHINE_TYPE} \
  --master-boot-disk-size ${DISK_SIZE} \
  --num-workers ${NUM_WORKERS} \
  --worker-machine-type ${MACHINE_TYPE} \
  --worker-boot-disk-size ${DISK_SIZE} \
  --image-version 1.4 \
  --scopes cloud-platform,pubsub,sql-admin \
  --tags mysql \
  --initialization-actions gs://goog-dataproc-initialization-actions-${REGION}/cloud-sql-proxy/cloud-sql-proxy.sh \
  --properties hive:hive.metastore.warehouse.dir=gs://${DATAWAREHOSE_DIR}/google-cloud-dataproc-warehouse-metainfo \
  --metadata enable-cloud-sql-proxy-on-workers=false,hive-metastore-instance=${PROJECT}:${REGION}:hive-metastore \
  --project ${PROJECT} \
  --enable-component-gateway
