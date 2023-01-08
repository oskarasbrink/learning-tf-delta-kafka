#!/bin/bash

ls -al


#Create an EC2 instance with Amazon Linux 2 with internet access
#Connect to your instance using putty
sudo cp cred/gh-ssh.pem /root/.ssh/id_rsa 
sudo ssh-add /root/.ssh/id_rsa
#Perform a quick update on your instance:
sudo yum update -y
 
#Install git in your EC2 instance
sudo yum install git -y


mkdir GIT && cd GIT
git clone https://github.com/oskarasbrink/learning-tf-delta-kafka.git


ls learning-tf-delta-kafka
cd learning-tf-delta-kafka
git checkout what-the-hell
pwd
cd ../..
#install docker
yes | sudo amazon-linux-extras install docker

sudo service docker start

sudo service docker status

#build
mkdir cred
cat aws-credentials > credentials.txt
echo "yeah man"
cat /home/ec2-user/credentials.txt
cd GIT/learning-tf-delta-kafka
sudo docker build -t spark3x-delta .

#chmod +x *.sh
chmod +x /home/ec2-user/GIT/learning-tf-delta-kafka/learn-terraform-docker-container/docker-start.sh
ls -al /home/ec2-user
ls -al /home/ec2-user/GIT/learning-tf-delta-kafka
ls -al /home/ec2-user/GIT/learning-tf-delta-kafka/learn-terraform-docker-container
pwd

sudo docker run --rm -i --name=spark3x-delta --mount type=bind,source=/home/ec2-user,destination=/root -p 4040:4040 spark3x-delta /root/docker-start.sh
#sudo docker run --rm -d -it --name=spark3x-delta --mount type=bind,source=/home/ec2-user/GIT,destination=/root/GIT -p 4040:4040 spark3x-delta /bin/bash /home/ec2-user/docker-start.sh
#docker run --rm  -i --name=haskell-pinot --env-file $SCRIPTS_DIR/env.list -v $GITHUB_TEMPMDBOOKDIR/dbc/scalable-data-science:/root/temp --mount type=bind,source=$GITHUB_DIR_TO_REPO,destination=/root/GIT lamastex/haskell-pinot:latest /bin/bash $localscriptDIRPATH/pinotMdBook.sh