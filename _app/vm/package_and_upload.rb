#!/usr/bin/env ruby

# ./_app/vm/package_and_upload.rb

package_file = ""

tag = `git describe --tags`
tag.chomp!

if tag !~ /\d+\.\d+.\d+/
  STDERR.puts "can't package because this doesn't look like a tagged commit"
  exit 1
end

package_file = "omnigrok-" + tag + ".box"

# if File.exist?("package.box")
#   STDERR.puts "looks like a package.box file is still hanging around.  please remove it."
#   exit 1
# end

# if File.exist?(package_file)
#   STDERR.puts "the package file #{package_file} already exists"
#   exit 1
# end

# puts "creating the vagrant package file #{package_file}"
# `vagrant halt`
# `vagrant package`
# `mv package.box #{package_file}`

# if ! File.exist?(package_file)
#   STDERR.puts "looks like we couldn't create the package file #{package_file}"
#   exit 1
# end

puts "uploading the vagrant package file #{package_file} to s3"
`./upload_to_s3.rb #{package_file}`
