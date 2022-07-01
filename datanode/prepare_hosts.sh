#!/bin/bash

#echo "Preparing /etc/hosts file on namenode"

#sudo echo "172.21.0.2    namenode"  >> /etc/hosts
#sudo echo "172.21.0.3    datanode1" >> /etc/hosts
#sudo echo "172.21.0.4    datanode2" >> /etc/hosts

#echo "Preparing /etc/hosts file on datanodes"

#ssh root@datanode1 'echo "172.21.0.2    namenode"  >> /etc/hosts
#                    echo "172.21.0.3    datanode1" >> /etc/hosts
#                    echo "172.21.0.4    datanode2" >> /etc/hosts'


#ssh root@datanode2 'echo "172.21.0.2    namenode"  >> /etc/hosts
#                    echo "172.21.0.3    datanode1" >> /etc/hosts
#                    echo "172.21.0.4    datanode2" >> /etc/hosts'

echo "Moving authorized_keys to hosts"

scp /home/hdoop/.ssh/authorized_keys hdoop@datanode1:/home/hdoop/.ssh/authorized_keys
scp /home/hdoop/.ssh/authorized_keys hdoop@datanode2:/home/hdoop/.ssh/authorized_keys

echo "Preparing masters file"

echo "namenode" > /home/hdoop/hadoop3/etc/hadoop/masters
echo "datanode1" > /home/hdoop/hadoop3/etc/hadoop/workers
echo "datanode2" >> /home/hdoop/hadoop3/etc/hadoop/workers

scp /home/hdoop/hadoop3/etc/hadoop/masters hdoop@datanode1:/home/hdoop/hadoop3/etc/hadoop/masters
scp /home/hdoop/hadoop3/etc/hadoop/masters hdoop@datanode1:/home/hdoop/hadoop3/etc/hadoop/workers

scp /home/hdoop/hadoop3/etc/hadoop/masters hdoop@datanode2:/home/hdoop/hadoop3/etc/hadoop/masters
scp /home/hdoop/hadoop3/etc/hadoop/masters hdoop@datanode2:/home/hdoop/hadoop3/etc/hadoop/workers

echo "Starting namenode"

/home/hdoop/hadoop3/sbin/start-dfs.sh

echo "All done!"