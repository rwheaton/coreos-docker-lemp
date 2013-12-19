# nginx + PHP5-FPM + MariaDB + supervisord on Docker
#
# VERSION               0.0.1
FROM        ubuntu:12.04
MAINTAINER  rtw 

# Step 3/4: Update packages
RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update

# Step 5: install curl, wget
RUN apt-get install -y curl wget

# Step 6-11: install stuff

# Install MariaDB
RUN apt-get -y install mysql-server
RUN sed -i 's/^innodb_flush_method/#innodb_flush_method/' /etc/mysql/my.cnf

# Install nginx
RUN apt-get -y install nginx

# Install PHP5 and modules
RUN apt-get -y install php5-fpm php5-mysql php-apc php5-imap php5-mcrypt php5-curl php5-gd php5-json

# Configure nginx for PHP websites
ADD nginx_default.conf /etc/nginx/sites-available/default
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

# Supervisord
RUN apt-get -y install python-setuptools
RUN easy_install supervisor
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 8080:80

CMD supervisord -n -c /etc/supervisord.conf
