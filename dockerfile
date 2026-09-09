# Stage 1: Build Environment
FROM drupal:php8.5-apache AS build-stage

# Set working directory
WORKDIR /opt/drupal

COPY ./composer.json ./composer.lock .

# RUN composer install --no-dev || composer update --lock && composer install --no-dev
RUN composer install --no-dev --optimize-autoloader

# Stage 2: Runtime environment
# FROM drupal:11-php8.3-apache AS final-stage
