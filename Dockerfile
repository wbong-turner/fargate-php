FROM ubuntu:14.04

MAINTAINER William Bong <william.bong@turner.com>

# Update the default application repository sources list.
RUN apt-get update

# Install apache2, php5, and required extensions.
RUN apt-get -y install apache2 php5 curl libapache2-mod-php5 php5-mysql php5-ldap php5-curl

# Update the PHP.ini file.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini

# Set up the apache environment variables.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Set up the web app environment variable.
ENV WEB_APP_DIR /var/www/trinity

# Expose apache.
EXPOSE 80

# Copy this repo into place.
ADD . $WEB_APP_DIR

# Create logs and upload directory and set full permission
RUN mkdir -m 777 $WEB_APP_DIR/logs
RUN mkdir -m 777 $WEB_APP_DIR/upload

# Update the default apache site.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interactive.
CMD /usr/sbin/apache2ctl -D FOREGROUND
