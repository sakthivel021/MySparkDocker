FROM centos:centos6
# SPARK
ENV SPARK_VERSION 2.4.0

ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop2.7
#Download Spark 
RUN yum install -y wget \ 
    && yum install -y java openssh-server vim \
    && wget -O spark.tar.gz  http://apache.volia.net/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz

#INSTALL SPARK
RUN mkdir -p /opt/ \
    && tar xvf spark.tar.gz -C /opt/ \
    && ln -s /opt/$SPARK_PACKAGE /opt/spark \
    &&mkdir /var/log/spark \
    && mkdir /tmp/spark \
    && mkdir /etc/spark/ \
    && mv /opt/spark/conf/* /etc/spark/ \
    && ln -s /etc/spark /opt/spark/conf 

EXPOSE 4040 
EXPOSE 7077 
EXPOSE 8088
WORKDIR /opt/spark

#SETTING ENVIRONMENT VARIABLES
ENV SPARK_HOME=/opt/spark
RUN echo "export HADOOP_CONF_DIR=/opt/spark/hadoop/etc/haddop" >> spark-env.sh
#RUN $SPARK_HOME/sbin/start-master.sh 
#RUN $SPARK_HOME/sbin/start-slave.sh http://localhost:7077
