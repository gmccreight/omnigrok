#!/usr/bin/env ruby

require 'rubygems'
require 'find'
require 'fileutils'

def main
  if ARGV[0] == "test_paths_for_file_ids"
    results = process_paths_for_file_ids()
    if results[:errors].size > 0
      results[:errors].each{|e| STDERR.puts e}
      puts "FAIL: fileids - there was at least one fileid error"
    else
      puts "OK: fileids - all files have a fileid and there were no collisions"
    end
  end
end

def process_paths_for_file_ids

  errors = []
  file_path_for = {}

  skip_dirs = %W{. .. .DS_Store .git _app unfinished}
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
          fileid = matches[1]
          if file_path_for[fileid]
            errors << "fileid #{fileid} collision: #{path} and #{file_path_for[fileid]}"
          else
            file_path_for[fileid] = path
          end
        end
      end

      if num_matches == 0
        errors << "no fileid in: #{path}"
      elsif num_matches > 1
        errors << "fileid written more than once in: #{path}"
      end

    end

  end

  return {:errors => errors, :file_paths_for => file_path_for}

end

main()
