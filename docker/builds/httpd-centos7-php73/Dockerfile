FROM    centos:7

#install git, php7.3 & httpd
RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    curl -sL https://rpm.nodesource.com/setup_10.x && \
    yum -y install nodejs && \
    yum -y update && \
    yum -y install --enablerepo=remi,remi-php73 \
                   php \
                   php-opcache \
                   php-devel \
                   php-bcmath \
                   php-intl \
                   php-mbstring \
                   php-pecl-memcached \
                   php-mcrypt \
                   php-mysqlnd \
                   php-pecl-xdebug \
                   php-gd \
                   php-fpm \
                   httpd \
                   sendmail \
                   git && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

#update httpd.conf
COPY httpd.conf /etc/httpd/conf/httpd.conf

#- Add directory config
COPY app-directory.conf /etc/httpd/conf.d/

#update php.ini
COPY php.ini /etc/php.ini

#port and entry
EXPOSE 80

WORKDIR /app

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]