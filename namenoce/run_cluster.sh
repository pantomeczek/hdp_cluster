#!/bin/bash

$HADOOP_HOME/sbin/start-dfs.sh 
$HADOOP_HOME/sbin/start-yarn.sh 
$SPARK_HOME/sbin/start-history-server.sh
$HIVE_HOME/bin/hive --service hiveserver2 &
#$HBASE_HOME/bin/start-hbase.sh
