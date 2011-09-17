#!/usr/bin/env ruby

# usage (from project base)
# ./_app/og_fileids.rb test_paths_for_ogfileids
# ./_app/og_fileids.rb path_for_ogfileid 20

require 'rubygems'
require 'find'
require 'fileutils'

def main
  if ARGV[0] == "test_paths_for_ogfileids"
    results = process_paths_for_ogfileids()
    if results[:errors].size > 0
      results[:errors].each{|e| STDERR.puts e}
      puts "FAIL: og_fileids - there was at least one ogfileid error"
    else
      puts "OK: og_fileids - all files have an ogfileid and there were no collisions"
    end
  elsif ARGV[0] == "path_for_ogfileid"
    ogfileid = ARGV[1]
    if ogfileid !~ /^\d+$/
      STDERR.puts "the ogfileid #{ogfileid} is not digits"
    else
      results = process_paths_for_ogfileids()
      filepath = results[:file_paths_for][ogfileid]
      if filepath
        puts filepath
      else
        STDERR.puts "could not find filepath for #{ogfileid}"
      end
    end
  end
end

def process_paths_for_ogfileids

  errors = []
  file_path_for = {}

  #Note that the unfinished files should also have ogfileids so they can be discussed easily
  skip_dirs = %W{. .. .DS_Store .git _app}
  skip_files = %W{.gitignore}

  Find.find(Dir.getwd) do |path|
    if FileTest.directory?(path)
      if skip_dirs.include?(File.basename(path))
        Find.prune
        next
      end
    end

    if FileTest.file?(path)

      if skip_files.include?(File.basename(path))
        next
      end

      num_matches = 0
      File.read(path).lines.each do |line|
        matches = line.match(/^.{0,2}ogfileid:(\d+)/)
        if matches
          num_matches += 1
          ogfileid = matches[1]
          if file_path_for[ogfileid]
            errors << "ogfileid #{ogfileid} collision: #{path} and #{file_path_for[ogfileid]}"
          else
            file_path_for[ogfileid] = path
          end
        end
      end

      if num_matches == 0
        errors << "no ogfileid in: #{path}"
      elsif num_matches > 1
        errors << "ogfileid written more than once in: #{path}"
      end

    end

  end

  return {:errors => errors, :file_paths_for => file_path_for}

end

main()
