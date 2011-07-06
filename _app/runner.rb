#!/usr/bin/env ruby

$commands = []
$results = ""
$is_dry_run = true
$run_practice = false

$debug = true

def main

  mode = ARGV[0]

  if !mode
    die "Please specify a mode as your first argument"
  end

  if mode == "run_normal" || mode == "run_practice" || mode == "dry_run" || mode == "do_all_tests_pass"
    dir = ARGV[1] + ""
    dir.gsub!(/\/$/,"") #trim trailing slash if it exists
    if !dir
      die "Please specify a directory as your second argument"
    end
    if mode == "run_normal" || mode == "run_practice" || mode == "do_all_tests_pass"
      $is_dry_run = false
    end
    if mode == "run_practice"
      $run_practice = true
    end
    run_tests_for_dir(dir)
    if mode == "run_normal" || mode == "run_practice"
      puts $results
    elsif mode == "do_all_tests_pass"
      h = info_for_type(type_for_dir(dir))
      if $results =~ %r{#{h[:passing_regex_str]}}
        puts "ALL TESTS PASSED"
      else
        puts $results
        puts "TESTS DID NOT ALL PASS FOR DIR #{dir}"
        puts %Q{using #{h[:passing_regex_str]} as the matching regular expression}
      end
    end
  else
    die "unrecognized mode #{mode}"
  end
end

def die(message)
  STDERR.puts "Whoops: #{message}"
  exit
end

def info_for_type(type)

  suffix = code_suffix_for_type(type)
  if !suffix
    STDERR.puts "Could not get the suffix for the type #{type}"
    return
  end

  if $run_practice
    sourcecode = "practice." + suffix
  else
    sourcecode = "code." + suffix
  end

  h = {:commands => [], :passing_regex_str => nil}

  if type == "c"
    # It's a C directory
    # Using Check, a unit testing framework for C
    h[:commands] << "gcc -o code.o -c #{sourcecode}"
    h[:commands] << "gcc -o unittests.o -c unittests.c"
    h[:commands] << "gcc -o unittests ../../_app/tests/frameworks/c_check/src/*.o code.o unittests.o"
    h[:commands] << "./unittests"

    h[:passing_regex_str] = "^100%"
  elsif type == "cc"
    # It's a C++ directory
    # Using Googletest, Google's C++ testing framework, version 1.4.0
    h[:commands] << "g++ -o code.o -c #{sourcecode}"
    h[:commands] << "g++ $(gtest-config --cppflags --cxxflags) -o unittests.o -c unittests.cc"
    h[:commands] << "g++ $(gtest-config --ldflags --libs) -o unittests ../../_app/tests/frameworks/cc_gtest/gtest_main.o code.o unittests.o"
    h[:commands] << "./unittests"

    h[:passing_regex_str] = "PASSED"
  elsif type == "clojure"
    # It's a clojure directory
    h[:commands] << "java -cp ../../_app/local/clojure/clojure.jar clojure.main unittests.clj"

    h[:passing_regex_str] = "^0 failures"
  elsif type == "coffee"
    # It's a coffeescript directory
    # Uses Rhino
    h[:commands] << "coffee -b -c *.coffee"
    #special case for coffeescript
    if $run_practice
      h[:commands] << "cp practice.js code_or_practice_copied.js"
    else
      h[:commands] << "cp code.js code_or_practice_copied.js"
    end
    h[:commands] << "java -jar ../../_app/tests/frameworks/js/js.jar unittests.js"
    h[:commands] << "rm code.js practice.js unittests.js" #special case for coffeescript

    h[:passing_regex_str] = "ALL TESTS PASSED"
  elsif type == "js"
    # It's a Javascript directory
    # Uses Rhino
    h[:commands] << "cp #{sourcecode} code_or_practice_copied.js"
    h[:commands] << "java -jar ../../_app/tests/frameworks/js/js.jar unittests.js"

    h[:passing_regex_str] = "ALL TESTS PASSED"
  elsif type == "go"
    # It's a go directory
    shared = "PATH=$PATH:#{Dir.getwd}/_app/local/go/bin"

    h[:commands] << "#{shared} gotest"
    h[:commands] << "rm -r _test"
    h[:commands] << "rm *.out"
    h[:commands] << "rm _gotest_.*"
    h[:commands] << "rm _testmain.*"
    h[:commands] << "rm _xtest_.*"

    h[:passing_regex_str] = "^PASS$"
  elsif type == "objc"
    # It's an objective c directory
    h[:commands] << "gcc -c -Wno-import #{sourcecode}"
    h[:commands] << "gcc -c -Wno-import unittests.m"
    h[:commands] << "gcc -o unittests -Wno-import #{sourcecode} unittests.o -lobjc"
    h[:commands] << "./unittests"

    h[:passing_regex_str] = "TODO - We don't have a unit test framework yet"
  elsif type == "py"
    # It's a python directory
    # Using pyunit
    h[:commands] << "cp #{sourcecode} code_or_practice_copied.py"
    h[:commands] << "python unittests.py"

    h[:passing_regex_str] = "^OK$"
  elsif type == "rb"
    # It's a ruby directory
    # Using test unit
    h[:commands] << "cp #{sourcecode} code_or_practice_copied.rb"
    h[:commands] << "ruby unittests.rb"
  elsif type == "scala"
    # It's a Scala directory
    shared = "PATH=$PATH:#{Dir.getwd}/_app/local/scala/bin;"
    h[:commands] << "#{shared} scalac -cp ../../_app/tests/frameworks/scalatest/scalatest-1.6.1.jar code.scala unittests.scala"
    h[:commands] << "#{shared} scala -cp ../../_app/tests/frameworks/scalatest/scalatest-1.6.1.jar org.scalatest.tools.Runner -p . -o -s unittests"

    h[:passing_regex_str] = "All tests passed"
  end

  return h
end

# foo/blah/stack_scala is type scala
# foo/bar/tree_coffee is type coffee
def type_for_dir(dir)
  if type = dir.match(/.+_([a-z]+)$/)
    return type[1]
  end
  nil
end

def code_suffix_for_type(type)
  return nil if type == nil
  if type == "objc"
    return "m"
  else
    return type
  end
end

def cleanup
  $commands << "rm -f *.o"
  $commands << "rm -f *.class"
  $commands << "rm -f unittests"
  $commands << "rm -rf code"
  $commands << "rm -f code_or_practice_copied.*"
end

def _run_commands
  $commands.each do |c|
    if $is_dry_run
      puts c
    else
      #Some things put their results as STDERR, like pyunit, so we need to redirect it to the results.
      $results << `#{c} 2>&1`
    end
  end
end

def run_tests_for_dir(dir)
  cleanup()
  h = info_for_type(type_for_dir(dir))
  h[:commands].each do |c|
    $commands << c
  end
  cleanup()
  Dir.chdir dir
  _run_commands()
end

main()
