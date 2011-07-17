# Enable a module that will allow you to proxy to 8022

a2enmod proxy_http

# Set the default file to add the ajaxterm section

cat > /etc/apache2/sites-available/default << "ENDOFFILE"

<VirtualHost *:80>
	ServerAdmin webmaster@localhost

	DocumentRoot /var/www

	### start of stuff added for ajaxterm ###
	ProxyRequests Off
	ProxyPass / http://localhost:8022/
	ProxyPassReverse / http://localhost:8022/
	### end of stuff added for ajaxterm ###

	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /var/www/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog ${APACHE_LOG_DIR}/access.log combined

    Alias /doc/ "/usr/share/doc/"
    <Directory "/usr/share/doc/">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>

ENDOFFILE

# Restart Apache

/etc/init.d/apache2 restart

#----------------------------------------------------------------------------------
# Make the terminal the ajaxterm shows fill up more of the screen as described here:
# http://wiki.kartbuilding.net/index.php/Ajaxterm#Larger_Terminal_Window

sed -i 's:ajaxterm.Terminal.*:ajaxterm.Terminal("term", 160, 40);:' /usr/share/ajaxterm/ajaxterm.html

#override the width and height passed in to the method by explicitly adding them in two lines following the __init__
sed -i '/__init__.*width/{n;s/^/\t\twidth = 160\n\t\theight = 40\n/}' /usr/share/ajaxterm/ajaxterm.py

/etc/init.d/ajaxterm restart

# End making terminal bigger
#----------------------------------------------------------------------------------
