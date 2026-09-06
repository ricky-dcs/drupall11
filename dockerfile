# Stage 1: Build Environment
FROM drupal:php8.4-apache AS build-stage

# Install Composer in the build stage (This might vary based on the base image)
# Install system dependencies and standard PHP extensions required for Drupal 11
RUN apt update && apt install -y \
    git \
    unzip

# Set working directory
WORKDIR /opt/drupal

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN rm -rf vendor

COPY ./composer.json .
COPY ./composer.lock .

# RUN composer install --no-dev || composer update --lock && composer install --no-dev
RUN composer install --no-dev 
RUN composer require drush/drush

# Stage 2: Runtime environment
FROM build-stage AS final-stage  
