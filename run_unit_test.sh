#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Import .env file
set -a
. ./.env
set +a

STEP_NAME=$1
if [ $# != 1 ]; then
	echo "Usage: $0 <STEP_NAME>"
	exit 1
fi

# First we prepare the NF file and config
${TESTING_SCRIPT_DIR}/prepare_nf.sh ${STEP_NAME}

# Then we prepare the YAML input for both CWL and NF
${TESTING_SCRIPT_DIR}/prepare_yaml.sh ${STEP_NAME}

# Then we run the CWL
pushd ${TOP_DIR}/cwl/${CWL_WF_DIR}/${STEP_NAME}/
echo "Running CWL for ${STEP_NAME} ... (in $(pwd))" 
$CWLTOOL_BIN ${STEP_NAME}.cwl ${STEP_NAME}.yaml
echo ""
echo "Finished ${STEP_NAME}. Files in $(pwd): "
for i in $(ls); do 
	if [ -f "$i" ]; then
		md5sum $i
	else
		echo "$i is a directory, skipping md5sum ..."
	fi
done
echo ""

# Then we run NF
popd
pushd ${TOP_DIR}/nf/${NF_WF_DIR}/${STEP_NAME}/
echo "Running NF for ${STEP_NAME} ... (in $(pwd))" 

# We would like to differentiate a fully-automated translation and a manually fine-tuned one.
# So here we create a new file and run nf with it. Ideal case is fully-automated == fine-tuned.
if [ ! -e "best_${STEP_NAME}.nf" ]; then
	echo "Best translation best_${STEP_NAME} does not exist, copying from automated translation ..."
	cp ${STEP_NAME}.nf best_${STEP_NAME}.nf
fi
# We also use best_nextflow.config whenever they exist.
if [ -e "best_nextflow.config" ]; then
	echo "Best config exist, copying it to nextflow.config ..."
	cp best_nextflow.config nextflow.config
fi


$NEXTFLOW_BIN run best_${STEP_NAME}.nf -params-file ${STEP_NAME}.yaml
NF_WORK_DIR=$(cat .nextflow.log | grep "Task monitor" | sed -r "s/.*workDir:\ (.*)\]/\1/")

echo ""
echo "Finished ${STEP_NAME}. Files in ${NF_WORK_DIR}"
for i in $NF_WORK_DIR/*; do
	if [ -f "$i" ]; then
		md5sum $i;
	else
		echo "$i is a directory, skipping md5sum ..."
	fi
done
echo ""
