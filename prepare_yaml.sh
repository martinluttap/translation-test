#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Import .env file
set -a
. ./.env
set +a

STEP_NAME=$1

python3 ${TOP_DIR}/wfe-log-parser/parse_cwl.py ${LOG_FILE} --generate_yaml $STEP_NAME

cp ${TOP_DIR}/wfe-log-parser/${STEP_NAME}.yaml ${TOP_DIR}/cwl/${CWL_WF_DIR}/${STEP_NAME}/
cp ${TOP_DIR}/wfe-log-parser/${STEP_NAME}.yaml ${TOP_DIR}/nf/${NF_WF_DIR}/${STEP_NAME}/

rm ${TOP_DIR}/wfe-log-parser/${STEP_NAME}.yaml

