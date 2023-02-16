#!/bin/bash

REG_TEST_SCRIPT_DIR=/home/martinlp/nextflow/per_tool_translation/scripts/


STEPS="
"

set -e

for STEP_NAME in ${STEPS}; do
	UPPER_STEP_NAME=$(echo ${STEP_NAME} | tr [:lower:] [:upper:])
	echo ""
	echo "=============== Running unit test for ${UPPER_STEP_NAME} ===================="
	echo ""
	${REG_TEST_SCRIPT_DIR}/run_unit_test.sh ${STEP_NAME}
	echo ""
	echo "====================== ${UPPER_STEP_NAME} done =============================="
	echo ""
done	

echo "All tests done!"
