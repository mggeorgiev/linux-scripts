#/bin/bash

sudo chown $(whoami) $(ls -1 | grep -v 'gz')
sudo ls -1 | grep 'kern' | grep -v '.gz' | xargs rm -f
sudo ls -1 | grep 'auth' | grep -v '.gz' | xargs rm -f