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

3.  Clone the KQMATH moodle repo into the web directory.

   cd /var/www
   sudo chown $USER .
   git clone --recursive git@github.com:KQMATH/moodle.git

   We use the KQMATH version because it includes a ready-made config
   file and all the required plugins as submodules.

4.  Configure apache.

   TODO

5.  Run the moodle install script.

  ./install.sh
