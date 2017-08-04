#! /bin/sh

mkdir -p /var/moodledata 
chgrp -R www-data /var/www/moodle
chown -R www-data.www-data /var/moodledata
chmod g+rwX /var/moodledata /var/www/moodle

cp hosts /etc/hosts
/etc/init.d/apache2 restart

sed -i -e "s/^[ 	]*ServerAdmin.*$/  ServerAdmin hasc@ntnu.no/" \
       -e "s/^[ 	]*DocumentRoot.*$/  DocumentRoot \/var\/www\/moodle\//" \
       /etc/apache2/sites-available/000-default.conf


sudo crontab crontab
sudo certbot --apache -d moodle.uials.no 

cd /var/www/moodle 
sudo -u www-data /usr/bin/php admin/cli/install_database.php \
            --agree-license --non-interactive \
            --adminemail=hasc@ntnu.no \
            --fullname="KQMATH Moodle Server" \
            --shortname="KQMATH" \
            --summary="Server for the KQMATH (Classroom Quiz) moodle plugin" \
            --adminpass=M00dle 

