#!/bin/bash

sudo apt update
sudo apt install curl php-cli php-mbstring git unzip

#download composer
#cd ~
#curl -sS https://getcomposer.org/installer -o composer-setup.php

#HASH=544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061
#php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo apt install composer
