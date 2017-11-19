docker exec -i hadoop0 /bin/bash <<EOF
echo -e "aaa bbb\naaa ccc\nccc eee" > /root/test.txt
hdfs dfs -put /root/test.txt /
cd /usr/local/hadoop/share/hadoop/mapreduce
hadoop jar hadoop-mapreduce-examples-2.7.4.jar wordcount /test.txt /out
EOF
