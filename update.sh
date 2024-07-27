#!/bin/bash
# Optionally run composer install for production use
if [ "$1" == "-c" ]; then
    composer install --optimize-autoloader --no-dev
fi

# Clear and cache configuration, routes, and views
php artisan config:cache
php artisan route:cache	
php artisan view:cache

# Restart PHP-FPM
systemctl restart php8.3-fpm

# Test Nginx configuration
nginx -t

# If the test was successful, reload Nginx
if [ $? -eq 0 ]; then
    systemctl reload nginx

    echo "Nginx reloaded"
else
    echo "Fail reload nginx"
    exit 1
fi
