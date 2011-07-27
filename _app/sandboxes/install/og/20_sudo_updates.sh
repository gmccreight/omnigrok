apt-get -y update

# Set the locale
locale-gen en_US.UTF-8

# Sometimes it fails, try again
locale-gen en_US.UTF-8

/usr/sbin/update-locale LANG=en_US.UTF-8

aptitude -y safe-upgrade

aptitude -y full-upgrade
