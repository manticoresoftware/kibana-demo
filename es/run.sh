#! /bin/sh

if [[ "$REGENERATE_LOG" == "1" ]];
then
	rm -rf /usr/share/elasticsearch/data/*
fi

/bin/tini -- /usr/local/bin/docker-entrypoint.sh

