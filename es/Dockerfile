FROM docker.elastic.co/elasticsearch/elasticsearch:7.17.0

COPY run.sh ./run.sh
RUN chmod +x ./run.sh

ENTRYPOINT ["./run.sh"]
CMD ["eswrapper"]

