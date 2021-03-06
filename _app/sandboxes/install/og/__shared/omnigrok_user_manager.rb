#!/usr/bin/ruby

@@users = []
@@users_filename = "omnigrok_users"

def code_of_length(x)
  result = ''
  array = (0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a
  (1..x).each do
    result += array[(rand * array.length).floor].to_s
  end
  result
end

def initial_setup
  (1..100).each do
    user = {}
    user[:login] = code_of_length(10)
    user[:used] = :not_used
    @@users << user
  end
  dump_users()
end

def setup
  load_users()
  if @@users.size == 0
    initial_setup()
  end
end

def put_all_users
  @@users.each do |user|
    puts user[:login] + " " + user[:used].to_s
  end
end

def put_next_user
  user = get_next_user()
  if user
    puts user[:login]
  end
end

def get_next_user

  @@users.each do |user|
    if user[:used] == :not_used
      user[:used] = :used
      dump_users()
      return user
    end
  end

  return nil
end

def dump_users
  File.open(@@users_filename,'w') do|file|
   Marshal.dump(@@users, file)
  end
  `chown ajaxterm #{@@users_filename}`
end

def load_users
  @@users = if File.exists?(@@users_filename)
              File.open(@@users_filename) do|file|
                Marshal.load(file)
              end
            else
              []
            end
end

def create_all_users
  @@users.each do |user|
    `useradd -d /home/#{user[:login]} -m #{user[:login]} -s /bin/bash`

    #Launch omnigrok immediately on login
    `echo "" >> /home/#{user[:login]}/.bashrc`
    `echo "### launch omnigrok immediately on login ###" >> /home/#{user[:login]}/.bashrc`
    `echo "cd omnigrok; vim -c \\"source _app/sandboxes/sandboxes.vim\\"" >> /home/#{user[:login]}/.bashrc`

    #Make it so that ajaxterm can login as the users using SSH keys [tag:user_login:gem]
    `mkdir /home/#{user[:login]}/.ssh`
    `cp /usr/share/ajaxterm/omnigrok_id_rsa.pub /home/#{user[:login]}/.ssh/authorized_keys`
    `chmod 600 /home/#{user[:login]}/.ssh/authorized_keys`

    #Copy the main files
    `cp -a /home/ubuntu/omnigrok /home/#{user[:login]}`

    #Copy the .vim files (so you can get NERDTree)
    `cp -a /home/ubuntu/.vim /home/#{user[:login]}`

    #Set the ownership of all the files
    `chown -R #{user[:login]}:#{user[:login]} /home/#{user[:login]}`

    #Link the big directories (but continue to have it be owned by ubuntu)
    `ln -s /home/ubuntu/omnigrok_app_local_to_link_to /home/#{user[:login]}/omnigrok/_app/local`
    `ln -s /home/ubuntu/omnigrok_app_tests_frameworks_to_link_to /home/#{user[:login]}/omnigrok/_app/og_tests/frameworks`

    #Block the user from having any access to the internet
    `echo pre-up iptables -A OUTPUT -p tcp -m owner --uid-owner #{user[:login]} -j DROP >> /etc/network/interfaces`
  end
end

setup()
if ARGV[0] == "next_user"
  put_next_user()
elsif ARGV[0] == "create_all_users"
  create_all_users()
end
