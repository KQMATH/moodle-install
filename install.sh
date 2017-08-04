#! /bin/sh

mkdir -p /var/moodledata 
chgrp -R www-data /var/www/html
chown -R www-data.www-data /var/moodledata
chmod g+rwX /var/moodledata /var/www/moodle

cd /var/www/moodle 
sudo -u www-data /usr/bin/php admin/cli/install_database.php \
            --agree-license --non-interactive \
            --adminemail=hasc@ntnu.no \
            --fullname="KQMATH Moodle Server" \
            --shortname="KQMATH" \
            --summary="Server for the KQMATH (Classroom Quiz) moodle plugin" \
            --adminpass=M00dle 

sudo certbot --apache -d moodle.uials.no 
sudo crontab crontab
