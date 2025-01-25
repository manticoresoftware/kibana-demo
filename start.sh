#! /bin/bash

while read -r line || [ -n "$line" ]; do eval $line; done < .env

if [[ "$REGENERATE_LOG" == "0" ]];
then
	LOAD_DATA_DIR="https://github.com/manticoresoftware/kibana-demo/releases/download/241227"
	ES_DATA_DIR="es_data_prepared"
	MANTICORE_DATA_DIR="manticore_data_prepared"

	# Download prepared data files from Github repo if they do not exist
	if [ ! -d "$ES_DATA_DIR" ];
	then
		ES_LOAD_DATA_DIR="${LOAD_DATA_DIR}/${ES_DATA_DIR}"
		wget "$ES_LOAD_DATA_DIR.z01" "$ES_LOAD_DATA_DIR.z02" "$ES_LOAD_DATA_DIR.z03" "$ES_LOAD_DATA_DIR.z04" "$ES_LOAD_DATA_DIR.zip"
		zip -FF "$ES_DATA_DIR.zip" --out "${ES_DATA_DIR}_tmp.zip"
		unzip "${ES_DATA_DIR}_tmp.zip" && rm -rf "${ES_DATA_DIR}_tmp.zip"
	fi
	if [ ! -d "$MANTICORE_DATA_DIR" ];
	then
		MANTICORE_LOAD_DATA_DIR="${LOAD_DATA_DIR}/${MANTICORE_DATA_DIR}"
		wget "$MANTICORE_LOAD_DATA_DIR.z01" "$MANTICORE_LOAD_DATA_DIR.z02" "$MANTICORE_LOAD_DATA_DIR.zip"
		zip -FF "$MANTICORE_DATA_DIR.zip" --out "${MANTICORE_DATA_DIR}_tmp.zip"
		unzip "${MANTICORE_DATA_DIR}_tmp.zip" && rm -rf "${MANTICORE_DATA_DIR}_tmp.zip"
	fi
else 
	ES_DATA_DIR="es_data"
	MANTICORE_DATA_DIR="manticore_data"
fi

# Pass saved Kibana objects for future import
if [ ! -f "./log-generator/kibana_objects.ndjson" ];
then
	cp -r ./kibana_objects.ndjson ./log-generator/kibana_objects.ndjson	
fi

ES_DATA_DIR=$ES_DATA_DIR MANTICORE_DATA_DIR=$MANTICORE_DATA_DIR docker-compose up
