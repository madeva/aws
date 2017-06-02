#!/bin/bash
sudo -i
mkdir /logs
docker cp $(docker ps -a | grep httpd | awk '{print $1;}'):/var/log/apache2 /logs
docker cp $(docker ps -a | grep mysql | awk '{print $1;}'):/var/log/mysql /logs
tar -czvf logs.tar.gz /logs
aws s3 cp logs.tar.gz s3://sudi-backup-bucket/