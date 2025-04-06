# Start from the official PHP-FPM image
FROM php:8.3-fpm

# Install additional dependencies (Node.js, Yarn, Composer, Nginx)
RUN apt-get update && apt-get install -y \
    nginx \
    npm \
    nodejs \
    unzip \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && npm install --global gulp-cli \
    && npm install -g yarn \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql zip mysqli exif \
    && docker-php-ext-enable mysqli pdo_mysql

# Set working directory based on project
WORKDIR /var/www/html

# Copy all project files to the container
COPY . .

# Set ownership of the web root directory to www-data
RUN chown -R www-data:www-data /var/www/html

# Make the startup script executable
RUN chmod +x /var/www/html/entrypoint.sh

# Fix uploads directory permissions
RUN chmod 755 -R /var/www/html/web/app/uploads/

# Copy Nginx default configuration
COPY ./config/nginx/default.conf /etc/nginx/sites-available/default

# Copy custom PHP configuration
COPY ./config/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Expose port 80 for Nginx
EXPOSE 80

# Use CMD to start Nginx and run the entrypoint script
#CMD service nginx start && sh /var/www/html/entrypoint.sh
CMD ["sh", "-c", "service nginx start && /var/www/html/entrypoint.sh"]
