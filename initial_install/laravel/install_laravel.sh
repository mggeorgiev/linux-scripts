#!/bin/bash

dir="naposao"
server_domain_or_IP="40.85.97.11"

#sudo apt update
#sudo apt install php-mbstring php-xml php-bcmath

#sudo mysql -h localhost -u root -p -e "CREATE DATABASE IF NOT EXISTS ${dir};"

#read -sp "Database Password for ${dir}_user: " password
#sudo mysql -h localhost -u root -p -e "GRANT ALL ON travel_list.* TO '${dir}_user'@'localhost' IDENTIFIED BY '${password}' WITH GRANT OPTION;"

cd ~
composer create-project --prefer-dist laravel/laravel $dir

cd $dir
php artisan

#sudo mv ~/$dir /var/www/$dir

#sudo chown -R www-data.www-data /var/www/$dir/storage
#sudo chown -R www-data.www-data /var/www/$dir/bootstrap/cache

#sudo nano /etc/nginx/sites-available/$dir

#sudo echo "server {" >> "/etc/nginx/sites-available/$dir"
#sudo echo "listen 80;" >> "/etc/nginx/sites-available/$dir"
#sudo echo "    server_name ${server_domain_or_IP};" >> "/etc/nginx/sites-available/$dir"
#sudo echo "    root /var/www/${dir}/public;" >> "/etc/nginx/sites-available/$dir" 
#
#sudo echo "    add_header X-Frame-Options "SAMEORIGIN";" >> "/etc/nginx/sites-available/$dir"
#sudo echo "    add_header X-XSS-Protection "1; mode=block";" >> "/etc/nginx/sites-available/$dir"
#sudo echo "    add_header X-Content-Type-Options "nosniff";" >> "/etc/nginx/sites-available/$dir"
#
#sudo echo "    index index.html index.htm index.php;" >> "/etc/nginx/sites-available/$dir"
#
#sudo echo "    charset utf-8;" >> "/etc/nginx/sites-available/$dir"
#
#sudo echo "    location / {" >> "/etc/nginx/sites-available/$dir"
#sudo echo "        try_files $uri $uri/ /index.php?$query_string;" >> "/etc/nginx/sites-available/$dir"
#sudo echo "    }" >> "/etc/nginx/sites-available/$dir"
#
#sudo echo "    location = /favicon.ico { access_log off; log_not_found off; }" >> "/etc/nginx/sites-available/$dir"
#sudo echo "    location = /robots.txt  { access_log off; log_not_found off; }" >> "/etc/nginx/sites-available/$dir"
#
#sudo echo "    error_page 404 /index.php;" >> "/etc/nginx/sites-available/$dir"
#
#sudo echo "    location ~ \.php$ {" >> "/etc/nginx/sites-available/$dir"
#sudo echo "        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;" >> "/etc/nginx/sites-available/$dir"
#sudo echo "        fastcgi_index index.php;" >> "/etc/nginx/sites-available/$dir"
#sudo echo "        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;" >> "/etc/nginx/sites-available/$dir"
#sudo echo "        include fastcgi_params;" >> "/etc/nginx/sites-available/$dir"
#sudo echo "    }" >> "/etc/nginx/sites-available/$dir"
#
#sudo echo "    location ~ /\.(?!well-known).* {"  >> "/etc/nginx/sites-available/$dir"
#sudo echo "        deny all;"  >> "/etc/nginx/sites-available/$dir"
#sudo echo "}"  >> "/etc/nginx/sites-available/$dir"

#sudo ln -s /etc/nginx/sites-available/$dir /etc/nginx/sites-enabled/

#sudo nano /etc/nginx/sites-available/$dir
