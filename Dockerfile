# Multiple elasticsearch cluster
#
# Version 0.1

FROM centos:latest

## Install elasticsearch
ENV CLUSTER01=myCluster01
ENV PORT01=9201
ENV CLUSTER02=myCluster02
ENV PORT02=9202
ENV CLUSTER03=myCluster03
ENV PORT03=9203
ENV CLUSTER04=myCluster04
ENV PORT01=9204
ENV CLUSTER05=myCluster05
ENV PORT05=9205

ADD elasticsearch.repo /etc/yum.repos.d/
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum update -y && yum install -y elasticsearch initscripts sudo which java-1.8.0-openjdk.x86_64

## Build 5 elasticsearch clusters
ADD start-new-elasticsearch-cluster.sh /
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER01 $PORT01
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER02 $PORT02
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER03 $PORT03
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER04 $PORT04
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER05 $PORT05

## Install postgresql
ENV $PGDATA=/var/lib/pgsql/data/
ENV $PG_USER=postgres
RUN yum install -y postgresql-server
RUN su - $PG_USER && initdb -D $PGDATA
