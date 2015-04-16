#!/bin/bash

mkdir -p /data/db/db-27020
mkdir -p /var/log/mongodb/

# run mongo instances
numactl --interleave=all mongod --port=27020 --replSet=rs_94_27020 --dbpath=/data/db/db-27020 --logpath=/var/log/mongodb/mongodb-db-27020.log --logappend --smallfiles
