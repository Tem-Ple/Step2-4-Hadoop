docker start hadoop0
docker start hadoop1
docker start hadoop2
docker start hadoop3

./setup-network.sh

cd ansible
ansible-playbook push_hosts.yml

docker exec -it hadoop0 /usr/local/hadoop/sbin/start-all.sh
docker exec -it hadoop1 /usr/local/zookeeper/bin/zkServer.sh start
docker exec -it hadoop2 /usr/local/zookeeper/bin/zkServer.sh start
docker exec -it hadoop3 /usr/local/zookeeper/bin/zkServer.sh start
