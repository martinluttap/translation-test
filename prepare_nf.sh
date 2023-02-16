#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Import .env file
set -a
. ./.env
set +a

STEP_NAME=$1

# Create folder for $STEP_NAME if it does not exist
if [ ! -d "${TOP_DIR}/nf/${NF_WF_DIR}/${STEP_NAME}" ]; then
    mkdir -p ${TOP_DIR}/nf/${NF_WF_DIR}/${STEP_NAME}
fi

CWL_PATH=${TOP_DIR}/cwl/${CWL_WF_DIR}/${STEP_NAME}/${STEP_NAME}.cwl
NF_PATH=${TOP_DIR}/nf/${NF_WF_DIR}/${STEP_NAME}/${STEP_NAME}.nf

python3 ${TOP_DIR}/cwl-translator/cwl_parse.py $CWL_PATH --unit_test --with_config > $NF_PATH 

CONF_FILE_PREFIX=$(cat $CWL_PATH | grep "^id" | sed -r 's/.*id: (.*)/\1/' | tr '[:lower:]' '[:upper:]')
mv ${TOP_DIR}/cwl-translator/${CONF_FILE_PREFIX}.nextflow.config ${TOP_DIR}/nf/${NF_WF_DIR}/${STEP_NAME}/nextflow.config
