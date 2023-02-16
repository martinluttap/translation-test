#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Import .env file
set -a
. ./.env
set +a

STEPS="
picard_validatesamfile
"

# Create folder for Nextflow tools if it doesn't exist
if [ ! -d "$TOP_DIR/nf/${NF_WF_DIR}" ]; then
    mkdir -p $TOP_DIR/nf/${NF_WF_DIR}
fi

# Clean the log just to make sure
${TESTING_SCRIPT_DIR}/remove_color.sh $LOG_FILE

# Now we loop through each step and do a unit test

for STEP_NAME in ${STEPS}; do
	UPPER_STEP_NAME=$(echo ${STEP_NAME} | tr [:lower:] [:upper:])
	echo ""
	echo "=============== Running unit test for ${UPPER_STEP_NAME} ===================="
	echo ""
	${TESTING_SCRIPT_DIR}/run_unit_test.sh ${STEP_NAME}
	echo ""
	echo "====================== ${UPPER_STEP_NAME} done =============================="
	echo ""
done	

echo "All tests done!"
