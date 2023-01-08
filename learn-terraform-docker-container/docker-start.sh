#!/bin/bash

echo "asd!!!"
ls -al 
ls /root/
cat credentials.txt
#cd /root/GIT/learning-tf-delta-kafka/lib
cd /root/GIT/exjobb/learning-tf-delta-kafka/lib
#cd /root/lib
sbt compile -debug
echo "asd!!!2"
sbt run
echo "hello world! inside docker"