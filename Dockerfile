FROM centos:centos6
# SPARK
ENV SPARK_VERSION 2.4.0

ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop2.7
#Download Spark 
RUN yum install -y wget \ 
    && yum install -y java \
    && wget -O spark.tar.gz  http://apache.volia.net/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz

#INSTALL SPARK
RUN mkdir -p /opt/ 
RUN tar xvf spark.tar.gz -C /opt/
RUN ln -s /opt/$SPARK_PACKAGE /opt/spark
RUN mkdir /var/log/spark
RUN mkdir /tmp/spark 
RUN mkdir /etc/spark/
RUN mv /opt/spark/conf/* /etc/spark/
RUN ln -s /etc/spark /opt/spark/conf 
WORKDIR /opt/spark
#SETTING ENVIRONMENT VARIABLES
RUN echo "export HADOOP_CONF_DIR=/opt/spark/hadoop/etc/haddop" >> spark-env.sh
