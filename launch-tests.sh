#!/bin/bash
# This script launch mvn test the required number of time ($1)
# if $1 is not specified, mvn test is launch once
# if $1 is -1, mvn test is launched until the script is killed (CTRL+C)

ROOT_OUTPUT_DIR="/eXo-Bonita/xcmis-tests.git/OUTPUT"

if [ -z $1 ]; then
	NBR="1"
else 
	NBR="$1"
fi

if [ ! -d "${ROOT_OUTPUT_DIR}" ]; then
	mkdir -p "${ROOT_OUTPUT_DIR}"
	mkdir -p "${ROOT_OUTPUT_DIR}/maven"
fi

# compute the current path
SCRIPT_DIR=$(dirname "$0")

PLAYED=0

function play_test_suite {
	LAUNCHED_TIMESTAMP=$(date +%Y%m%d_%H%M%S)
	mvn test 2>&1 > "${ROOT_OUTPUT_DIR}/maven/mvn-exec-${LAUNCHED_TIMESTAMP}-${PLAYED}.log"
}

while [[ $NBR -lt 0 || $PLAYED -lt $NBR ]]; do

	let PLAYED++
	echo $PLAYED
	echo "#$(date '+%Y%m%d %H%M%S')# launching test suite number $PLAYED"
	play_test_suite
	
done

