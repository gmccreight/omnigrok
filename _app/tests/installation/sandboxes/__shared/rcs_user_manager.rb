#!/usr/bin/ruby

@@users = []
@@users_filename = "rcs_users"

def code_of_length(x)
  result = ''
  array = (0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a
  (1..x).each do
    result += array[(rand * array.length).floor].to_s
  end
  result
end

def initial_setup
  (1..10).each do
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
    `useradd -d /home/#{user[:login]} -m #{user[:login]}`

    #Make it so that ajaxterm can login as the users using SSH keys
    #[tag:question:gem]
    #Does this really have to be multiple steps?
    `mkdir /home/#{user[:login]}/.ssh`
    `chown #{user[:login]}:#{user[:login]} /home/#{user[:login]}/.ssh`

    `cp /usr/share/ajaxterm/rcs_id_rsa.pub /home/#{user[:login]}/.ssh/authorized_keys`
    `chown #{user[:login]}:#{user[:login]} /home/#{user[:login]}/.ssh/authorized_keys`
    `chmod 600 /home/#{user[:login]}/.ssh/authorized_keys`
  end
end

setup()
if ARGV[0] == "next_user"
  put_next_user()
elsif ARGV[0] == "create_all_users"
  create_all_users()
end
