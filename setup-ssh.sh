#!/bin/bash

for i in {0..2}
do
docker exec -i hadoop$i /bin/bash <<EOF
rm -rf /root/.ssh
EOF
done
