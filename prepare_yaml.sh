#!/bin/bash
set -a
. ./.env
set +a

PREP_YAML_STEP_NAME=$1

python3 ${PREP_YAML_TOP_DIR}/wfe-parser/parse_cwl.py ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_LOG_FILE} --generate_yaml $PREP_YAML_STEP_NAME

cp ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_STEP_NAME}.yaml ${PREP_YAML_TOP_DIR}/cwl/${PREP_YAML_CWL_WF_DIR}/${PREP_YAML_STEP_NAME}/
cp ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_STEP_NAME}.yaml ${PREP_YAML_TOP_DIR}/nf/${PREP_YAML_NF_WF_DIR}/${PREP_YAML_STEP_NAME}/

rm ${PREP_YAML_TOP_DIR}/wfe-parser/${PREP_YAML_STEP_NAME}.yaml

