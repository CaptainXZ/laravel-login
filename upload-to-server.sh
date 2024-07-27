#!/bin/bash

# Define variables
currentlaraveldir=$(pwd)
remote=learning
deploy_dir=/var/www/html/api-testing

# Copy the routes folder to the remote server
rsync -avz "$currentlaraveldir/routes" "$remote:$deploy_dir"

# Copy resource folder to the remote server
rsync -avz "$currentlaraveldir/resources" "$remote:$deploy_dir"

# Copy view folder to the remote server
rsync -avz "$currentlaraveldir/resources/views" "$remote:$deploy_dir/resources"


# SSH into the remote server and run Laravel commands
ssh "$remote" << EOF
    cd $deploy_dir
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    echo "Routes folder deployed and Laravel commands executed successfully."
EOF
