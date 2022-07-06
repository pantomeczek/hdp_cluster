#!/bin/bash

declare -a datanodes=("datanode1" "datanode2" "datanode3")

#echo "Moving authorized_keys to datanodes"
#for val in ${datanodes[@]}; do
#   echo "-sending to ${val}"
#   scp /home/hdoop/.ssh/authorized_keys hdoop@$val:/home/hdoop/.ssh/authorized_keys
#done

rm /home/hdoop/.ssh/known_hosts

echo "Preparing list of masters and workers"

echo "namenode" > /home/hdoop/hadoop3/etc/hadoop/masters
echo ""         > /home/hdoop/hadoop3/etc/hadoop/workers

for val in ${datanodes[@]}; do
   echo "- adding ${val}"
   echo $val >> /home/hdoop/hadoop3/etc/hadoop/workers
done

echo "Moving lists of masters and workers to datanodes"
for val in ${datanodes[@]}; do
    echo "- sending to ${val}"
    scp -o "StrictHostKeyChecking no" /home/hdoop/hadoop3/etc/hadoop/*ers hdoop@$val:/home/hdoop/hadoop3/etc/hadoop/
done

echo "All done!"