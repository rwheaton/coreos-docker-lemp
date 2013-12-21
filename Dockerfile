# nginx + PHP5-FPM + mysql-server + supervisord on Docker
#
FROM        ubuntu:12.04
MAINTAINER  rtw 

# Step 3/4: Update packages
RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update

# Step 5: install curl, wget
RUN apt-get install -y curl wget

# Step 8-EOF: install stuff and stuff

# Install mysql-server
RUN apt-get -y install mysql-server mysql-client upstart
RUN sed -i 's/^innodb_flush_method/#innodb_flush_method/' /etc/mysql/my.cnf

# Install nginx
RUN apt-get -y install nginx

# Install PHP5 and modules
RUN apt-get -y install php5-fpm php5-mysql php-apc php5-mcrypt php5-curl php5-gd php5-json php5-cli
RUN sed -i -e "s/short_open_tag = Off/short_open_tag = On/g" /etc/php5/fpm/php.ini

# Configure nginx for PHP websites
ADD nginx_default.conf /etc/nginx/sites-available/default
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

# Supervisord
RUN apt-get -y install python-setuptools
RUN easy_install supervisor
ADD supervisord.conf /etc/supervisord.conf

RUN mkdir -p /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/index.php

EXPOSE 80

#And Start
#CMD /usr/bin/mysqld_safe &&
#CMD service php5-fpm start; service nginx start ; tail -f /var/log/nginx/error.log
CMD supervisord -n -c /etc/supervisord.conf
