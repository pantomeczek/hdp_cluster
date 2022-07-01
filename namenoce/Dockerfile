FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y iputils-ping 
RUN apt-get install -y net-tools
RUN apt-get install -y software-properties-common
RUN apt-get install -y vim
RUN apt-get install -y sudo


RUN echo 'root:motorolla' | chpasswd

RUN apt-get install -y ssh \
    && sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && service ssh start

RUN apt-get install -y openjdk-8-jdk \
    && echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment \
    && echo "JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> /etc/environment

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

RUN useradd -ms /bin/bash hdoop \
    && echo 'hdoop:motorolla' | chpasswd \
    && usermod -aG sudo hdoop

RUN mkdir /home/hdoop/.ssh \ 
    && mkdir /home/hdoop/hadoop3 \
    && mkdir /home/hdoop/spark \
    && mkdir /home/hdoop/hadoopfiles \
    && chown hdoop:hdoop -R /home/hdoop \ 
    && chmod 700 -R /home/hdoop

RUN ssh-keygen -q -t rsa -N '' -f /home/hdoop/.ssh/id_rsa \
    && cat /home/hdoop/.ssh/id_rsa.pub >> /home/hdoop/.ssh/authorized_keys \
    && chmod 0600 /home/hdoop/.ssh/authorized_keys \
    && chown hdoop:hdoop -R /home/hdoop/.ssh/

COPY ./hadoop-3.3.3 /home/hdoop/hadoop3
COPY ./spark /home/hdoop/spark
COPY ./prepare_hosts.sh /home/hdoop/

RUN chown hdoop:hdoop -R /home/hdoop 

RUN echo "export HADOOP_HOME=/home/hdoop/hadoop3" >> /home/hdoop/.bashrc \
    && echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> /home/hdoop/.bashrc \
    && echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> /home/hdoop/.bashrc \
    && echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> /home/hdoop/.bashrc \
    && echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> /home/hdoop/.bashrc \
    && echo "export YARN_HOME=\$HADOOP_HOME" >> /home/hdoop/.bashrc \
    && echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native" >> /home/hdoop/.bashrc \
    && echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> /home/hdoop/.bashrc \
    && echo "export HADOOP_OPTS=\"-Djava.library.path=\$HADOOP_HOME/lib/nativ\"" >>/home/hdoop/.bashrc

RUN echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> /home/hdoop/.bashrc \
    && echo "export SPARK_HOME=/home/hdoop/spark" >> /home/hdoop/.bashrc \
    && echo "export PATH=\$PATH:\$SPARK_HOME/bin" >> /home/hdoop/.bashrc \
    && echo "export LD_LIBRARY_PATH=\$HADOOP_HOME/lib/native:\$LD_LIBRARY_PATH" >> /home/hdoop/.bashrc 

EXPOSE 22

#Resource Manager
EXPOSE 9870

EXPOSE 54311

#hadoop cluster ui
EXPOSE 8088

EXPOSE 7077
EXPOSE 18080

CMD ["/usr/sbin/sshd","-D"]