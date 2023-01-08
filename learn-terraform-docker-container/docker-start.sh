#!/bin/bash

echo "asd!!!"
ls -al 
ls /root/
cat credentials.txt
cd /root/GIT/learning-tf-delta-kafka/lib
sbt compile
echo "asd!!!2"
sbt run
echo "hello world! inside docker"