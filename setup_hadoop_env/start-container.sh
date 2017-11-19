docker start hadoop0
docker start hadoop1
docker start hadoop2

./setup-network.sh

cd ansible
ansible-playbook push_hosts.yml
