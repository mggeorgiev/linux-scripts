

dir="naposao"
server_domain_or_IP="40.85.97.11"

#sudo mv ~/$dir /var/www/$dir

sudo chown -R www-data.www-data /var/www/$dir/storage
sudo chown -R www-data.www-data /var/www/$dir/bootstrap/cache

#sudo nano /etc/nginx/sites-available/$dir

sudo echo "server {" >> "/etc/nginx/sites-available/$dir"
sudo echo "listen 80;" >> "/etc/nginx/sites-available/$dir"
sudo echo "    server_name ${server_domain_or_IP};" >> "/etc/nginx/sites-available/$dir"
sudo echo "    root /var/www/${dir}/public;" >> "/etc/nginx/sites-available/$dir" 
#
#    add_header X-Frame-Options "SAMEORIGIN";
#    add_header X-XSS-Protection "1; mode=block";
#    add_header X-Content-Type-Options "nosniff";
#
#    index index.html index.htm index.php;
#
#    charset utf-8;
#
#    location / {
#        try_files $uri $uri/ /index.php?$query_string;
#    }
#
#    location = /favicon.ico { access_log off; log_not_found off; }
#    location = /robots.txt  { access_log off; log_not_found off; }
#
#    error_page 404 /index.php;
#
#    location ~ \.php$ {
#        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
#        fastcgi_index index.php;
#        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
#        include fastcgi_params;
#    }
#
sudo echo "    location ~ /\.(?!well-known).* {"  >> "/etc/nginx/sites-available/$dir"
sudo echo "        deny all;"  >> "/etc/nginx/sites-available/$dir"
sudo echo "}"  >> "/etc/nginx/sites-available/$dir"

sudo ln -s /etc/nginx/sites-available/$dir /etc/nginx/sites-enabled/

sudo nano /etc/nginx/sites-available/$dir


