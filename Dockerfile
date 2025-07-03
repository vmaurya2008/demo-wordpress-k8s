FROM wordpress:php8.1-apache

# Install system dependencies required for PostgreSQL extensions
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo_pgsql pgsql
