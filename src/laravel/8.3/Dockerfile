FROM php:8.3-fpm AS laravel

WORKDIR /var/www/html
USER root

RUN apt-get update; \
    apt-get upgrade -yqq; \
    pecl -q channel-update pecl.php.net

RUN apt-get install -yqq --no-install-recommends \
        apt-utils \
        cron \
        zsh \
        unzip \
        nano \
        curl \
        gnupg \
        ca-certificates \
        libcurl4-openssl-dev \
        libssl-dev \
        supervisor \
        git \
        libgmp-dev  \
        libonig-dev \
        libsasl2-dev \
        libzip-dev \
        libzstd-dev; \
    apt-get clean; \
    apt-get autoclean

######################################## php, composer

COPY ../php.ini /usr/local/etc/php/php.ini

RUN curl -o /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar
RUN chmod +x /usr/local/bin/composer

######################################## php exts

RUN docker-php-ext-install bcmath gettext exif mbstring pcntl pdo_mysql zip
RUN docker-php-ext-enable opcache

RUN apt-get install -yqq --no-install-recommends icu-devtools libicu-dev zlib1g-dev g++
RUN docker-php-ext-install intl

RUN pecl -q install -o -f redis && rm -rf /tmp/pear
RUN docker-php-ext-enable redis

######################################## puppeteer

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_CHROME_PATH=/usr/bin/google-chrome

RUN curl -SL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install google-chrome-stable -yqq --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

######################################## php user

ARG UID=1000
ARG GID=1000

ENV UID=${UID}
ENV GID=${GID}

RUN addgroup --gid ${GID} --system php
RUN adduser --uid ${UID} --system --ingroup php --disabled-password --shell /bin/zsh --home /home/php php

RUN mkdir -p /home/php/.composer && chown -R php /home/php

RUN sed -i "s/user = www-data/user = php/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = php/g" /usr/local/etc/php-fpm.d/www.conf

######################################## zsh

USER php

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions "/home/php/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
RUN git clone https://github.com/sindresorhus/pure.git "/home/php/.zsh/pure"

COPY ../.zshrc "/home/php/.zshrc"
USER root

######################################## node, bun

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg; \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list; \
    apt-get update; \
    apt-get -y install --no-install-recommends nodejs; \
    apt-get clean; \
    apt-get autoclean

RUN npm up -g
RUN npm i -g bun

########################################

EXPOSE 9000

USER php
CMD ["php-fpm"]

################################################################################

FROM laravel AS horizon

WORKDIR /var/www/html
USER root

######################################## supervisor

COPY --chown=root:root ../supervisord.conf /etc/supervisor/supervisord.conf

RUN mkdir -p /var/log/supervisor; \
    touch \
    /var/log/supervisor/supervisord.log \
    /var/log/supervisor/horizon.log \
    /var/log/supervisor/horizon.err.log \
    /var/log/supervisor/scheduler.log \
    /var/log/supervisor/scheduler.err.log

RUN chown -R php /var/log/supervisor
RUN chown -R php /var/www/html

RUN wget -q "https://github.com/aptible/supercronic/releases/download/v0.2.26/supercronic-linux-amd64" -O /usr/bin/supercronic \
  && chmod +x /usr/bin/supercronic \
  && mkdir -p /etc/supercronic \
  && echo "*/1 * * * * php /var/www/html/artisan schedule:run --verbose --no-interaction" > /etc/supercronic/laravel;

########################################

USER root
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
