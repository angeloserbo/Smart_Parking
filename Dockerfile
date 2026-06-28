FROM php:8.2-fpm

RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY . /var/www/html/

# Install nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Configure nginx to proxy to PHP-FPM
RUN echo 'server { \
    listen 80; \
    root /var/www/html; \
    index index.php; \
    location ~ \.php$ { \
        fastcgi_pass 127.0.0.1:9000; \
        fastcgi_index index.php; \
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; \
        include fastcgi_params; \
    } \
}' > /etc/nginx/sites-available/default

# Start both PHP-FPM and nginx
CMD php-fpm -D && nginx -g "daemon off;"
