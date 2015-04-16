MongoDB ReplicaSet Dockerfile
=============================

A Dockerfile and config for launching a MongoDB contatiner with 3 mongo processes that act as a ReplicaSet. There are config files for each mongo instance that are copied to the container. The shell script handles creation of the data directories and starting mongo.

### Notes

It's probably not a good idea to run this setup in production as each mongo instance should be split across different machines. However for a local development environment this fits our needs.

### Base Docker Image

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


### Installation

1. Install [Docker](https://www.docker.com/).
2. docker build -t="mongodb_replica_set:0.1.0" .

### Usage

Refer to [Dockerfile MongoDB](https://github.com/dockerfile/mongodb) for usage notes not specific to ReplicaSet

#### Create container from image and open ports for ReplicaSet

    docker run -d --hostname=219.224.135.94 --name=mongodb_rs_94_27020_27020 -p 27020:27020 -v /var/log/scrapy_guba_mongodb/:/var/log/mongodb/ -v /home/docker/docker-mongodb-replica-set/bin/:/mongodb/ -v /var/lib/scrapy_guba_mongodb/:/data/db/ mongodb_replica_set:0.1.0 /mongodb/start_rs_94_27020_27020.sh
    
    docker run -d --hostname=219.224.135.94 --name=mongodb_rs_94_27020_27021 -p 27021:27021 -v /var/log/scrapy_guba_mongodb/:/var/log/mongodb/ -v /home/docker/docker-mongodb-replica-set/bin/:/mongodb/ -v /var/lib/scrapy_guba_mongodb/:/data/db/ mongodb_replica_set:0.1.0 /mongodb/start_rs_94_27020_27021.sh

#### Initiate ReplicaSet

Once the container is running you can initialize the ReplicaSet with the following steps:

* Access shell of container with `docker exec -it mongodb bash`
* Access mongo shell with `mongo`
* `rs.initiate()` to initiate ReplicaSet
* Use the output of previous step to grab the 'me' (hostname of the machine) property to add to ReplicaSet:
	* port 27018: `rs.add('9488f884u84:27018')`
	* port 27019: `rs.add('9488f884u84:27019')`
* You can use `rs.status()` to see if your ReplicaSet has started successfully	
