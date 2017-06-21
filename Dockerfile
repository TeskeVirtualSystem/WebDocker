FROM ubuntu:16.04
MAINTAINER Lucas Teske <lucas@teske.net.br>

RUN apt-get update -y && apt-get install software-properties-common locales -y
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y && apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5.6 apache2 php5.6-cli php5.6-common php5.6-curl php5.6-gd php5.6-imap php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-opcache php5.6-readline php5.6-soap

# Enable apache mods.
RUN a2enmod php5.6
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/5.6/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/5.6/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 80
EXPOSE 443

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND