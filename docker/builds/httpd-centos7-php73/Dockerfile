FROM    centos:7

#install git, php7.3 & httpd
RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum -y install http://mirror.centos.org/centos/7/os/x86_64/Packages/openssl-1.0.2k-16.el7.x86_64.rpm && \
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
                   php-xml \
                   httpd \
                   sendmail \
                   openssl \
                   git && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN yum -y upgrade && yum clean all

#update httpd.conf
COPY httpd.conf /etc/httpd/conf/httpd.conf

#- Add directory config
COPY app-directory.conf /etc/httpd/conf.d/

#update php.ini
COPY php.ini /etc/php.ini
COPY 15-xdebug.ini /etc/php.d/15-xdebug.ini

#port and entry
EXPOSE 80

COPY tools/entrypoint /tools/entrypoint
COPY tools/permission_fix /tools/permission_fix

RUN ["chmod", "+x", "/tools/entrypoint"]

RUN mkdir -p /var/data

WORKDIR /app

ENTRYPOINT ["/tools/entrypoint"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]