# moodle-install

Install scripts and instructions

These files explains how to make a Moodle installation on Ubuntu 16.04,
with the necessary trimmings to use the KQMATH plugin.  It is not meant
to be useful in any other context.

1.  We use a standard NTNU/IIR image which includes Ubuntu 16.04 with
  PostgreSQL and Docker.  (We do not expect to need Docker, but we will
  use PostgreSQL.)

2.  Install dependencies (assuming postgresql is already installed).

   sudo apt-get install maxima gnuplot apache2 php php-pear phppgadmin
   sudo apt-get install php-curl php-zip php-gd 

3.  Clone the KQMATH moodle repo into the web directory.

   cd /var/www
   sudo chown $USER .
   git clone --recursive git@github.com:KQMATH/moodle.git

   We use the KQMATH version because it includes a ready-made config
   file and all the required plugins as submodules.

4.  Configure apache.

   sudo vi /etc/apache2/sites-available/000-default.conf 

   Edit the following two lines:

   ServerAdmin hasc@ntnu.no
   DocumentRoot /var/www/moodle

5.  Create the DB.

   $ sudo -u postgres psql
   postgres=# CREATE USER moodleuser WITH PASSWORD 'KlasseromsQuiz';
   CREATE ROLE
   postgres=# CREATE DATABASE moodle WITH OWNER moodleuser;
   CREATE DATABASE

   See https://docs.moodle.org/33/en/PostgreSQL for details

6.  Configure db access.

  sudo vi /etc/postgresql/9.5/main/pg_hba.conf 

  Moodle wants to send passwords in cleartext.  This requires the
  following two lines in the file.

  host    moodle        moodleuser      127.0.0.1/32            password
  host    moodle        moodleuser      ::1/128                 password


7.  Run the moodle install script.

   sudo ./install.sh

* Additional notes on reinstallation

Step 5.

   Drop the existing database.

   postgres=# DROP DATABASE moodle ;
   DROP DATABASE

   The create the DB as above.  It is not necessary to create the user.

  
