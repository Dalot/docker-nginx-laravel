FROM ubuntu:18.04

LABEL Rogerio Dalot

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y gnupg tzdata \
    && echo "UTC" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
    && apt-get install -y nginx curl zip unzip git software-properties-common supervisor sqlite3 \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php7.3-fpm php7.3-cli php7.3-gd php7.3-mysql php-soap php7.3-soap\
       php7.3-pgsql php7.3-imap php-memcached php7.3-mbstring php7.3-xml php7.3-curl \
       php7.3-sqlite3 php7.3-xdebug \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

ADD virtual_host.conf /etc/nginx/sites-available/default
ADD nginx.conf /etc/nginx/nginx.conf
ADD php.ini /etc/php/7.3/fpm/php.ini
ADD php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
ADD www.conf /etc/php/7.3/fpm/pool.d/www.conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start-container.Unix.sh /usr/bin/start-container
RUN chmod +x /usr/bin/start-container


ENTRYPOINT ["start-container"]