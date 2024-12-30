FROM golang:alpine

COPY ./nginx-log-generator ./nginx-log-generator
COPY ./run.sh ./run.sh
COPY ./kibana_objects.ndjson ./kibana_objects.ndjson

RUN apk add --update nodejs npm curl
RUN npm install elasticdump -g

ENTRYPOINT ["sh", "run.sh"]