#!/bin/bash
set -e -x
# Needed so that the aptitude/apt-get operations will not be interactive
export DEBIAN_FRONTEND=noninteractive
sudo -i
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
apt-get --yes --quiet update && apt-get -y --quiet upgrade && apt-get -y --quiet install icinga icinga-doc icinga-idoutils mysql-server libdbd-mysql mysql-client docker.io python
python get-pip.py
pip install awscli
service ido2db start && sudo service icinga start && sudo service apache2 start
sudo -i
mkdir /apache-new
cd /apache-new
wget https://s3.ap-south-1.amazonaws.com/sudi-files/my-httpd.conf
wget https://s3.ap-south-1.amazonaws.com/sudi-files/Dockerfile
docker build -t apache_httpd:latest .
docker run -i  -t -p 1080:80 apache_httpd /bin/bash
htpasswd -c /etc/apache2/.htpasswd ubuntu
service apache2 start
# pull the docker image
docker pull mysql
# run the container on top of the image
docker run -p 3900:3306 --name mysql -e MYSQL_ROOT_PASSWORD=toor -d mysql:latest
# add docker apache and mysql to icinga monitoring
cd /etc/icinga/objects/
wget https://s3.ap-south-1.amazonaws.com/sudi-files/extra.cfg
export AWS_ACCESS_KEY_ID=AKIAIZEKOXS2LHKGH2SQ
export AWS_SECRET_ACCESS_KEY=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
aws s3 mb s3://sudi-backup-bucket2
wget https://s3.ap-south-1.amazonaws.com/sudi-files/collect-logs.sh
wget https://s3.ap-south-1.amazonaws.com/sudi-files/backup.sh
echo “0 19 * * *  root /bin/bash collect-logs.sh “ >> /etc/crontab
echo “0 19 * * *  root /bin/bash backup.sh “ >> /etc/crontab
echo " " >> /etc/crontab