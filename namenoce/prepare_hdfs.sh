#!/bin/bash

hdfs namenode -format
hdfs dfs -mkdir /spark-logs
hdfs dfs -mkdir /tmp

hdfs dfs -chmod g+w /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /user/hive/warehouse