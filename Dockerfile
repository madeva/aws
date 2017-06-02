FROM ubuntu
MAINTAINER ubuntu@ec2-35-154-247-61.ap-south-1.compute.amazonaws.com
RUN apt-get update
RUN apt-get -y install apache2
RUN echo 'Apache installed on docker on ec2-35-154-247-61.ap-south-1.compute.amazonaws.com' > /var/www/html/index.html
COPY ./my-httpd.conf /etc/apache2/conf-enabled/httpd.conf
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh
RUN echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh
RUN echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh
RUN echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh
RUN chmod 755 /root/run_apache.sh
EXPOSE 80
CMD /root/run_apache.sh