# moodle-install

Install scripts and instructions

These files explains how to make a Moodle installation on Ubuntu 16.04,
with the necessary trimmings to use the KQMATH plugin.  It is not meant
to be useful in any other context.

1.  We use a standard NTNU/IIR image which includes Ubuntu 16.04 with
  PostgreSQL and Docker.  (We do not expect to need Docker, but we will
  use PostgreSQL.)

2.  Install dependencies (assuming postgresql is already installed).

   ```
   sudo add-apt-repository ppa:certbot/certbot
   sudo apt-get update
   sudo apt-get install apache2 php php-pear phppgadmin libapache2-mod-php \
             python-certbot-apache php-curl php-zip php-gd \
             gnuplot sendmail gdebi
   ```

3.  Configure sendmail

   ```
   sudo sendmailconfig
   ```

   Answer Y to every question

4.  Install maxima (if you are going to use STACK)

   ```
   sudo gdebi maxima_5.40.0-1_amd64.deb
   ```

5.  Clone the KQMATH moodle repo into the web directory.

   ```
   cd /var/www
   sudo chown $USER .
   git clone --branch KQM_33 --recursive git@github.com:KQMATH/moodle.git
   ```

   or, if you prefer, clone using HTTP instead:

   ```
   git clone --branch KQM_33 --recursive https://github.com/KQMATH/moodle.git
   ```

   We use the KQMATH version because it includes a ready-made config
   file and all the required plugins as submodules.


6.  Create the DB.

   ```
   $ sudo -u postgres psql
   postgres=# CREATE USER moodleuser WITH PASSWORD 'KlasseromsQuiz';
   CREATE ROLE
   postgres=# CREATE DATABASE moodle WITH OWNER moodleuser;
   CREATE DATABASE
   ```

   See https://docs.moodle.org/33/en/PostgreSQL for details

7.  Configure db access.

  ```
  sudo vi /etc/postgresql/9.5/main/pg_hba.conf 
  ```

  Moodle wants to send passwords in cleartext.  This requires the
  following two lines in the file.

  ```
  host    moodle        moodleuser      127.0.0.1/32            password
  host    moodle        moodleuser      ::1/128                 password
  ```


8.  Run the moodle install script.

   sudo ./install.sh

# Additional notes on reinstallation #

Step 6.

   Drop the existing database.

   ```
   postgres=# DROP DATABASE moodle ;
   DROP DATABASE
   ```

   The create the DB as above.  It is not necessary to create the user.

  
* Settings to change

The DB password is hardcoded in config.php and in the PostgreSQL command
above.  This should be changed, although it may not be a problem. The
default config does not appear to accept DB connections from a remote
host.

The Moodle admin password is hardcoded in install.sh.  This MUST be changed.

The hostname is hardcoded in the following files and must be changed
for installation on a different host.
  - config.php (moodle repo) - check the moodle URL
  - hosts (this repo)
  - install.sh (this repo)

The host name is explicit in the sendmail config above (Step 3).

Note. config.php is in the moodle repo.
