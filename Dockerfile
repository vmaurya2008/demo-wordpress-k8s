FROM wordpress:php8.1-apache
RUN docker-php-ext-install pdo_pgsql pgsql