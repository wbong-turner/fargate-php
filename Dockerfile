FROM ubuntu:14.04

MAINTAINER William Bong <william.bong@turner.com>

# Update the default application repository sources list.
RUN apt-get update

# Install apache2, php5, and required extensions.
RUN apt-get -y install apache2 php5 libapache2-mod-php5 php5-mysql php5-ldap curl

# Update the PHP.ini file,
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini

# Set up the apache environment variables.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 80

# Copy this repo into place.
ADD . /var/www/trinity

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND
