FROM php:8.2-apache

# Remove all MPM module files from both mods-available and mods-enabled,
# then enable only mpm_prefork to prevent "More than one MPM loaded" error
RUN rm -f /etc/apache2/mods-available/mpm_*.load /etc/apache2/mods-available/mpm_*.conf && \
    rm -f /etc/apache2/mods-enabled/mpm_*.load /etc/apache2/mods-enabled/mpm_*.conf && \
    a2enmod mpm_prefork rewrite

RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY . /var/www/html/
