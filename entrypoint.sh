#!/bin/bash

# Ensure the script knows the project directory
PROJECT_DIR="/var/www/html"

# Set the working directory
cd $PROJECT_DIR

# Install Composer dependencies
if [ ! -d vendor ]; then
    if [ "$APP_ENV" = "staging" ] || [ "$APP_ENV" = "production" ]; then
        echo "Installing Project's Root Composer dependencies without dev packages..."
        composer install --no-dev --optimize-autoloader --no-progress --no-suggest --no-interaction --no-scripts
    else
        echo "Installing Project's Root Composer dependencies (with dev packages)..."
        composer install
    fi
fi

cd ./web/app/themes/sage

# Install Composer dependencies for theme
if [ ! -d vendor ]; then
    if [ "$APP_ENV" = "staging" ] || [ "$APP_ENV" = "production" ]; then
        echo "Installing Theme's Root Composer dependencies without dev packages..."
        composer install --no-dev --optimize-autoloader --no-progress --no-suggest --no-interaction --no-scripts
    else
        echo "Installing Theme's Root Composer dependencies (with dev packages)..."
        composer install
    fi
fi

# Install Yarn dependencies and build theme assets
if [ ! -d node_modules ]; then
    echo "Installing Yarn dependencies for the theme..."

    if [ "$APP_ENV" = "staging" ] || [ "$APP_ENV" = "production" ]; then
        yarn install --frozen-lockfile --prefer-offline --no-progress
    else
        yarn install
    fi

    if [ "$APP_ENV" = "staging" ] || [ "$APP_ENV" = "production" ]; then
        echo "Building theme assets..."
        yarn build

        echo "Deleting node_modules in production/staging environment..."
        rm -rf node_modules
    fi
fi

# Check for the environment and fix permissions
if [ "$APP_ENV" = "staging" ] || [ "$APP_ENV" = "production" ]; then
    # Fix file permissions
    echo "Fixing file and directory permissions..."

    # Set directory permissions to 755
    find /var/www/html -type d -exec chmod 755 {} \;

    # Set file permissions to 644
    find /var/www/html -type f -exec chmod 644 {} \;

    echo "Permissions fixed."
else
    # Fix file permissions
    echo "Fixing file and directory permissions..."

    # Ensure proper ownership for development environment
    chown -R www-data:www-data /var/www/html/

    # Set file permissions to 777
    chmod 777 -R /var/www/html

    echo "Permissions fixed."
fi

cd $PROJECT_DIR
cd ./web/app/themes/sage

# Start PHP-FPM
echo "Starting PHP-FPM..."
php-fpm