#!/usr/bin/env ruby
#
# ./upload_to_s3.rb package_filename

require 'rubygems'
require 'aws/s3'
require 'fileutils'
require 'ruby-debug'

module AWS::S3

  package_file_to_upload = ARGV[0]

  if ! File.exist?(package_file_to_upload)
    STDERR.puts "the file #{package_file_to_upload} cannot be uploaded because it does not exist"
    exit 1
  end

  bucket = "omnigrok"

  Base.establish_connection!(
    :access_key_id     => ENV["AMAZON_ACCESS_KEY_ID_FOR_OMNIGROK"],
    :secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY_FOR_OMNIGROK"]
  )

  debugger
  f = open(File.expand_path(package_file_to_upload))

  S3Object.store(
    f,
    bucket,
    :access => :public_read
  )

  # For example, this might upload a file accessible at:
  # http://s3.amazonaws.com/omnigrok/vagrant/omnigrok-0.1.1.box
  
end
