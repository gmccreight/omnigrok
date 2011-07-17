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
