sudo -i
mkdir  /backup
cd /backup
docker commit -p $(docker ps -a | grep httpd | awk '{print $1;}') backup-apache
docker save -o backup-apache.tar  backup-apache
docker commit -p $(docker ps -a | grep mysql | awk '{print $1;}') backup-mysql
docker save -o backup-mysql .tar backup-mysql 
tar -czvf my-first-backup.tar.gz /backup
aws s3 cp my-first-backup.tar.gz s3://sudi-backup-bucket/ 