#!/bin/bash

PREP_NF_STEP_NAME=$1
PREP_NF_CWL_WF_DIR=gdc-rnaseq-cwl
PREP_NF_NF_WF_DIR=martin-rnaseq-nf
PREP_NF_TOP_DIR=/home/martinlp/nextflow/per_tool_translation/

CWL_PATH=${PREP_NF_TOP_DIR}/cwl/${PREP_NF_CWL_WF_DIR}/${PREP_NF_STEP_NAME}/${PREP_NF_STEP_NAME}.cwl
NF_PATH=${PREP_NF_TOP_DIR}/nf/${PREP_NF_NF_WF_DIR}/${PREP_NF_STEP_NAME}/${PREP_NF_STEP_NAME}.nf

python3 ${PREP_NF_TOP_DIR}/cwl-translator/cwl_parse.py $CWL_PATH --unit_test --with_config > $NF_PATH 

CONF_FILE_PREFIX=$(cat $CWL_PATH | grep "^id" | sed -r 's/.*id: (.*)/\1/' | tr '[:lower:]' '[:upper:]')
mv ${PREP_NF_TOP_DIR}/cwl-translator/${CONF_FILE_PREFIX}.nextflow.config ${PREP_NF_TOP_DIR}/nf/${PREP_NF_NF_WF_DIR}/${PREP_NF_STEP_NAME}/nextflow.config
