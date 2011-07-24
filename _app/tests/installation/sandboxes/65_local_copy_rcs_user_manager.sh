source __shared/library.sh
load_var URI

scp rcs_user_manager.rb root@$URI:/usr/share/ajaxterm/
