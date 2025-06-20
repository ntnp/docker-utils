FROM php:8.3-fpm AS laravel
USER root
WORKDIR /tmp

########################################
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
USER root

COPY --chown=root:root ../php.ini /usr/local/etc/php/php.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

######################################## php exts
USER root

RUN docker-php-ext-install bcmath gettext exif mbstring pcntl pdo_mysql zip
RUN docker-php-ext-enable opcache

RUN apt-get install -yqq --no-install-recommends icu-devtools libicu-dev zlib1g-dev g++
RUN docker-php-ext-install intl

RUN pecl -q install -o -f redis && rm -rf /tmp/pear
RUN docker-php-ext-enable redis

######################################## php user
USER root

ARG UID=1000
ARG GID=1000

ENV UID=${UID}
ENV GID=${GID}

RUN addgroup --gid ${GID} --system php
RUN adduser --uid ${UID} --system --ingroup php --disabled-password --shell /usr/bin/zsh --home /home/php php

RUN mkdir -p /home/php/.composer && chown -R php /home/php

RUN sed -i "s/user = www-data/user = php/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = php/g" /usr/local/etc/php-fpm.d/www.conf

######################################## zsh
USER php

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
    git clone https://github.com/zsh-users/zsh-autosuggestions /home/php/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
    git clone https://github.com/sindresorhus/pure.git /home/php/.zsh/pure

COPY --chown=php:php ../.zshrc /home/php/.zshrc

######################################## node, bun
USER root

RUN curl -sL https://deb.nodesource.com/setup_22.x | bash; \
    apt-get install -y nodejs

RUN node -v; \
    npm -v; \
    npm i -g npm bun

######################################## chrome, puppeteer
USER root

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_CHROME_PATH=/usr/bin/google-chrome

RUN apt-get -yqq install \
      wget \
      fonts-liberation \
      libasound2 \
      libatk-bridge2.0-0 \
      libatk1.0-0 \
      libatspi2.0-0 \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libdrm2 \
      libgbm1 \
      libglib2.0-0 \
      libgtk-3-0 \
      libgtk-4-1 \
      libnspr4 \
      libnss3 \
      libpango-1.0-0 \
      libu2f-udev \
      libvulkan1 \
      libx11-6 \
      libxcb1 \
      libxcomposite1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxkbcommon0 \
      libxrandr2 \
      xdg-utils; \
    apt-get clean; \
    apt-get autoclean

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb

########################################
USER php
WORKDIR /var/www/html

EXPOSE 9000
CMD ["php-fpm"]

################################################################################
FROM laravel AS horizon
USER root
WORKDIR /tmp

######################################## supervisor
USER root

COPY --chown=root:root ../supervisord-horizon.conf /etc/supervisor/supervisord.conf

RUN mkdir -p /var/log/supervisor; \
    touch \
        /var/log/supervisor/supervisord.log \
        /var/log/supervisor/horizon.log \
        /var/log/supervisor/horizon.err.log \
        /var/log/supervisor/scheduler.log \
        /var/log/supervisor/scheduler.err.log

RUN chown -R php:php /var/log/supervisor

RUN wget -q "https://github.com/aptible/supercronic/releases/download/v0.2.26/supercronic-linux-amd64" -O /usr/bin/supercronic \
  && chmod +x /usr/bin/supercronic \
  && mkdir -p /etc/supercronic \
  && echo "* * * * * php /var/www/html/artisan schedule:run --verbose --no-interaction" > /etc/supercronic/laravel;

########################################
USER php

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

################################################################################
FROM laravel AS reverb
USER root
WORKDIR /tmp

######################################## supervisor
USER root

COPY --chown=root:root ../supervisord-reverb.conf /etc/supervisor/supervisord.conf

RUN mkdir -p /var/log/supervisor; \
    touch \
        /var/log/supervisor/supervisord.log \
        /var/log/supervisor/reverb.log \
        /var/log/supervisor/reverb.err.log

RUN chown -R php /var/log/supervisor

########################################
USER php

EXPOSE 8080
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
