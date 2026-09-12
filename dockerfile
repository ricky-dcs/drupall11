# Stage 1: Build Environment
FROM drupal:11.4.6-php8.4-apache AS build-stage

# Set working directory
WORKDIR /opt/drupal

# Install dependencies
COPY ./composer.json ./composer.lock .
RUN composer install --no-dev --optimize-autoloader

# Copy local files
COPY ./web/modules /opt/drupal/web/modules
COPY ./web/profiles /opt/drupal/web/profiles
COPY ./web/themes /opt/drupal/web/themes
COPY ./config/production/settings.php /opt/drupal/web/sites/default/settings.php

# Stage 2: Runtime environment
FROM drupal:11.4.6-php8.4-apache AS final-stage

# Set working directory
WORKDIR /opt/drupal

# copy from build stage source to destination path in the final stage container
COPY --from=build-stage /opt/drupal /opt/drupal
