#!/bin/bash

mkdir -p /data/db/db-27021
mkdir -p /var/log/mongodb/

# run mongo instances
numactl --interleave=all mongod --port=27021 --replSet=rs_95_27020 --dbpath=/data/db/db-27021 --logpath=/var/log/mongodb/mongodb-db-27021.log --logappend --smallfiles
