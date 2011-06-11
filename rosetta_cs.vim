" Switch to the buffer if it is open, otherwise 'edit' the file
function! BufferOrEdit(filename)
    let fname = a:filename

    " If a file extension isn't already specified, figure it out based on
    " directory type
    if match(fname, "\\.") < 0
        let dir = expand("%:h")
        if match(dir, "_c$") > 0
            " It's a C directory
            let fname = fname . ".c"
        elseif match(dir, "_cc$") > 0
            " It's a C++ directory
            let fname = fname . ".cc"
        elseif match(dir, "_coffee$") > 0
            " It's an coffeescript directory
            let fname = fname . ".coffee"
        elseif match(dir, "_objc$") > 0
            " It's an objective c directory
            let fname = fname . ".m"
        elseif match(dir, "_rb$") > 0
            " It's a Ruby directory
            let fname = fname . ".rb"
        elseif match(dir, "_js$") > 0
            " It's a Javascript directory
            let fname = fname . ".js"
        endif
    endif

    if bufexists(fname)
        execute "buffer " . fname
    else
        if filereadable(fname)
            execute "edit " . fname
        endif
    endif

endfunction

" Since every folder has a standard structure, it's easy to bounce between the
" files.
map ,t :call BufferOrEdit(expand("%:h") . "/unittests")<cr>
map ,c :call BufferOrEdit(expand("%:h") . "/code")<cr>
map ,h :call BufferOrEdit(expand("%:h") . "/code.h")<cr>
map ,p :call BufferOrEdit(expand("%:h") . "/practice")<cr>

map <c-j> :call RunUnitTestsForDir()<cr>

" If directories have a standard structure, it's easy to run the unit tests
" in them.  See the 'linked_list' directory for an example.
function! RunUnitTestsForDir()
    let cwd = getcwd()
    let dir = expand("%:h")
    let current_file = expand("%")

    execute "cd " . dir
    
    " If you happen to be editing the practice file, then compile using the
    " practice file instead of the standard "code" file
    let sourcecode = match(current_file, "practice") > 0 ? "practice" : "code" 

    if match(dir, "_c$") > 0
        " It's a C directory
        " Using Check, a unit testing framework for C
        write
        silent !rm *.o
        exec "!gcc -o code.o -c " . sourcecode . ".c"
        !gcc -o unittests.o -c unittests.c
        silent !rm ./unittests
        !gcc -o unittests ../../tests/frameworks/c_check/src/*.o code.o unittests.o
        !./unittests | tee ../../tests/integration/tmp_tests_out.txt
        silent !rm ./unittests
        silent !rm *.o
    elseif match(dir, "_cc$") > 0
        " It's a C++ directory
        " Using Googletest, Google's C++ testing framework, version 1.4.0
        write
        silent !rm *.o
        exec "!g++ -o code.o -c " . sourcecode . ".cc"
        !g++ $(gtest-config --cppflags --cxxflags) -o unittests.o -c unittests.cc
        silent !rm ./unittests
        !g++ $(gtest-config --ldflags --libs) -o unittests ../../tests/frameworks/cc_gtest/gtest_main.o code.o unittests.o
        !./unittests | tee ../../tests/integration/tmp_tests_out.txt
        silent !rm ./unittests
        silent !rm *.o
    elseif match(dir, "_coffee$") > 0
        " It's a coffeescript directory
        " Uses Rhino
        write
        exec "!coffee -b -c *.coffee"
        exec "!cp " . sourcecode . ".js code_or_practice_copied.js"
        !java -jar ../../tests/frameworks/js/js.jar unittests.js | tee ../../tests/integration/tmp_tests_out.txt
        silent !rm code.js
        silent !rm practice.js
        silent !rm code_or_practice_copied.js
        silent !rm unittests.js
    elseif match(dir, "_objc$") > 0
        " It's an objective c directory
        write
        silent !rm *.o
        exec "!gcc -c -Wno-import " . sourcecode . ".m"
        !gcc -c -Wno-import unittests.m
        exec "!gcc -o unittests -Wno-import " . sourcecode . ".o unittests.o -lobjc"
        !./unittests | tee ../../tests/integration/tmp_tests_out.txt
        silent !rm ./unittests
        silent !rm *.o
    elseif match(dir, "_rb$") > 0
        " It's a ruby directory
        " Using test unit
        write
        exec "!cp " . sourcecode . ".rb code_or_practice_copied.rb" 
        !ruby unittests.rb | tee ../../tests/integration/tmp_tests_out.txt
        silent !rm code_or_practice_copied.rb 
    elseif match(dir, "_js$") > 0
        " It's a Javascript directory
        " Uses Rhino
        write
        exec "!cp " . sourcecode . ".js code_or_practice_copied.js" 
        !java -jar ../../tests/frameworks/js/js.jar unittests.js | tee ../../tests/integration/tmp_tests_out.txt
        silent !rm code_or_practice_copied.js
    endif

    execute "cd " . cwd
endfunction
