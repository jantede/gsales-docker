# This Dockerfile creates an instance of gSales using nginx and php-fpm

FROM 			richarvey/nginx-php-fpm:1.5.0
MAINTAINER		Jan Tede Mehrtens <tede@noez.de>

ENV				GSALES_REVISION	1121

# Install ioncube loader
RUN cd /tmp \
	&& wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -qO - | tar xfvz - \
	&& mv ioncube/ioncube_loader_lin_7.2.so /usr/local/lib/php/extensions/ \
	&& rm -rf ioncube \
	&& echo "zend_extension=/usr/local/lib/php/extensions/ioncube_loader_lin_7.2.so" > /usr/local/etc/php/conf.d/00_ioncubeloader.ini
	
# Download gsales
RUN wget https://www.gsales.de/download/gsales2-rev${GSALES_REVISION}-php71.tar.gz -qO - | tar --strip=1 -xzC /var/www/html \
	&& mv /var/www/html/lib/inc.cfg.dist.php /var/www/html/lib/inc.cfg.php

## Expose Ports
EXPOSE	80 443

# Run nginx
CMD ["/start.sh"]