#!/bin/bash

PREP_YAML_STEP_NAME=$1
PREP_YAML_CWL_WF_DIR=gdc-rnaseq-cwl
PREP_YAML_NF_WF_DIR=martin-rnaseq-nf
PREP_YAML_LOG_FILE=rnaseq-cwl.log
PREP_YAML_TOP_DIR=/home/martinlp/nextflow/per_tool_translation/

python3 ${PREP_YAML_TOP_DIR}/wfe-parser/parse_cwl.py ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_LOG_FILE} --generate_yaml $PREP_YAML_STEP_NAME

cp ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_STEP_NAME}.yaml ${PREP_YAML_TOP_DIR}/cwl/${PREP_YAML_CWL_WF_DIR}/${PREP_YAML_STEP_NAME}/
cp ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_STEP_NAME}.yaml ${PREP_YAML_TOP_DIR}/nf/${PREP_YAML_NF_WF_DIR}/${PREP_YAML_STEP_NAME}/

rm ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_STEP_NAME}.yaml

