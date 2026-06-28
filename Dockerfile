FROM php:8.2-apache

# Inaayos nito ang nag-aaway na Apache modules (MPM error)
RUN a2dismod mpm_event mpm_worker || true && a2enmod mpm_prefork rewrite

RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY . /var/www/html/
