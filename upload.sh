#!/bin/bash

# Get the current Laravel directory
currentlaraveldir=$(pwd)
remote=learning
deploy_dir=/var/www/html/api-testing

# Check for the composer flag
run_composer=false
if [ "$1" == "-c" ]; then
    run_composer=true
fi

# Create a tar.gz archive of the Laravel project, excluding unnecessary folders
tar --exclude='node_modules' --exclude='vendor' --exclude='.git' --exclude='storage/logs' -czvf laravel.tar.gz -C "$currentlaraveldir" .

# Copy the archive to the remote server
scp laravel.tar.gz "$remote":/var/www/html

# SSH into the server and perform deployment steps
ssh "$remote" << EOF
  # Remove old deployment if it exists
  rm -rf "$deploy_dir"

  # Create new directory
  mkdir -p "$deploy_dir"
  cd "$deploy_dir"
  # Extract the new build
  tar -xzvf /var/www/html/laravel.tar.gz

  # Replace .env with .env.prod
  cp .env.prod .env


  # Clean up the tar file
  rm /var/www/html/laravel.tar.gz
  bash update.sh -c

  # Set correct permissions
  chown -R www-data:www-data "$deploy_dir"
  chmod -R 755 "$deploy_dir"
  # Run the update scrip 
EOF

# Clean up local tar file
rm laravel.tar.gz

echo "Deployment process completed."
