#!/bin/bash

#########################################################################
#
# Author: Darren Tu  github.com/darrentu
# Please read README before running the program
# Modified by : Martin Putra (martinluttap@uchicago.edu)
#
#########################################################################

#!/bin/bash

set -e

if [ $# != 2 ]; then
	echo "Usage: $0 <DB_PATH> <JOB_UUID>"
	exit 1
fi

#if [ "$1" = "" ]
#then
#	echo "You must enter the name of the database. Please check the README."
#	exit 1
#fi

db=$1
JOB_UUID=$2
CSV_FOLDER="."
TARGET_FOLDER=$CSV_FOLDER/$JOB_UUID

if [[ ! -e  $TARGET_FOLDER ]]; then
	mkdir -p $TARGET_FOLDER
	t=($(sqlite3 $db ".tables"))

	for i in "${t[@]}"
	do
		sqlite3 $db<<- EXIT_HERE
		.mode csv
		.headers on
		.output $TARGET_FOLDER/$i.csv
		SELECT * FROM $i;
		.exit
		EXIT_HERE
		echo "$TARGET_FOLDER/$i.csv generated"
	done
else
	echo "$TARGET_FOLDER exists, skipping ..."
fi


#mv $db $TARGET_FOLDER
#echo "Copied $db to $TARGET_FOLDER"