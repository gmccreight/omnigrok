#----------------------------------------------------------------------------------
# Make the terminal the ajaxterm shows fill up more of the screen as described here:
# http://wiki.kartbuilding.net/index.php/Ajaxterm#Larger_Terminal_Window

sed -i 's:ajaxterm.Terminal.*:ajaxterm.Terminal("term", 160, 40);:' /usr/share/ajaxterm/ajaxterm.html

#override the width and height passed in to the method by explicitly adding them in two lines following the __init__
sed -i '/__init__.*width/{n;s/^/\t\twidth = 160\n\t\theight = 40\n/}' /usr/share/ajaxterm/ajaxterm.py

/etc/init.d/ajaxterm restart

# End making terminal bigger
#----------------------------------------------------------------------------------

#----------------------------------------------------------------------------------
# Make ajaxterm use the results of an executed script to set the login
sed -i '/sys\.stdout\.write.*login/{s/^/#/;n;s/^/#/;n;s/^/\t\t\t\tlogin=os.popen(".\/omnigrok_user_manager.rb next_user").read().strip()\n/}' /usr/share/ajaxterm/ajaxterm.py

/etc/init.d/ajaxterm restart

# End changing the login
#----------------------------------------------------------------------------------

#----------------------------------------------------------------------------------
# Make ajaxterm use a special identity file
sed -i '/PreferredAuthentications/{s/^/#/;n;s/^/\t\t\t\t\tcmd+=["-i\/usr\/share\/ajaxterm\/omnigrok_id_rsa"]\n/}' /usr/share/ajaxterm/ajaxterm.py

/etc/init.d/ajaxterm restart

# End using special identity file
#----------------------------------------------------------------------------------
