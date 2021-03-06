#!/bin/bash

docker pull pockost/shinken:2.4-webui2-base
docker run --rm -v ${PWD}/config:/data pockost/shinken:2.4-webui2-base cp -r /etc/shinken /data
docker run --rm -v ${PWD}/data:/data pockost/shinken:2.4-webui2-base cp -r /var/lib/shinken /data
docker-compose run --rm arbiter shinken install retention-mongodb
sudo sed -i 's/localhost/graphite/' config/shinken/modules/graphite.cfg
sudo sed -i 's/YOURSERVERNAME/graphite/' config/shinken/modules/ui-graphite.cfg
sudo sed -i 's/modules webui2/modules webui2,graphite/' config/shinken/brokers/broker-master.cfg
sudo sed -i 's/localhost/mongo/' config/shinken/modules/retention-mongodb.cfg
#docker-compose run --rm shinken install http
