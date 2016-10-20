# Pull base image.
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

RUN apt-get update \
    && apt-get install -y hbase \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

ADD docker_files/hbase-master-run.sh /apps/hbase-master-run.sh
ADD docker_files/hbase-regionserver-run.sh /apps/hbase-regionserver-run.sh
ADD docker_files/hbase-rest-run.sh /apps/hbase-rest-run.sh
ADD docker_files/hbase-thrift-run.sh /apps/hbase-thrift-run.sh
ADD docker_files/hbase-thrift2-run.sh /apps/hbase-thrift2-run.sh
RUN chmod a+x /apps/*.sh

# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

EXPOSE 60000 60010 60020 60030 2181 2888 3888 8080 8085 9090 9095 11060

CMD ["/bin/bash"]
