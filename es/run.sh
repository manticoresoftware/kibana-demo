#! /bin/sh

rm -rf /usr/share/elasticsearch/data/*

/bin/tini -- /usr/local/bin/docker-entrypoint.sh

