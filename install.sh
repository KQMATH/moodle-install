#! /bin/sh

mkdir /var/moodledata 
chgrp -R www-data /var/moodledata /var/www/html
chmod g+rwX /var/moodledata /var/www/html

/usr/bin/php admin/cli/install_database.php \
            --agree-license --non-interactive \
            --adminemail=hasc@ntnu.no \
            --fullname="KQMATH Moodle Server" \
            --shortname="KQMATH" \
            --summary="Server for the KQMATH (Classroom Quiz) moodle plugin" \
            --adminpass=M00dle 
