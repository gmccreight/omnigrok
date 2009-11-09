" Using Googletest, Google's C++ testing framework, version 1.4.0

" Don't reload the NERDTree and grep options...
if !exists('g:cs_loaded')
    let g:cs_loaded = 1

    " Set the EasyGrep options
    let g:EasyGrepRecursive = 1
    source $HOME/.vim/plugin/EasyGrep.vim
    " Set user-defined files for grepping
    execute "normal \\vojjj\<cr>*.cc *.h\<cr>q"

    " Open NERDTree
    NERDTree
    /stack_c/
    normal o
    nohls
endif

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
        endif
    endif

    if bufexists(fname)
        execute "buffer " . fname
    else
        execute "edit " . fname
    endif

endfunction

" Since every folder has a standard structure, it's easy to bounce between the
" files.
map ,t :call BufferOrEdit(expand("%:h") . "/unittests")<cr>
map ,c :call BufferOrEdit(expand("%:h") . "/code")<cr>
map ,h :call BufferOrEdit(expand("%:h") . "/code.h")<cr>

map <c-j> :call RunUnitTestsForDir()<cr>

" If directories have a standard structure, it's easy to run the unit tests
" in them.  See the 'linked_list' directory for an example.
function! RunUnitTestsForDir()
    let cwd = getcwd()
    let dir = expand("%:h")
    execute "cd " . dir

    if match(dir, "_c$") > 0
        " It's a C directory
        write
        silent !rm *.o
        !gcc -o code.o -c code.c
        !gcc -o unittests.o -c unittests.c
        silent !rm ./unittests
        !gcc -o unittests ../_test_c_check/src/*.o code.o unittests.o
        !./unittests
        silent !rm ./unittests
        silent !rm *.o
    elseif match(dir, "_cc$") > 0
        " It's a C++ directory
        write
        silent !rm *.o
        !g++ -o code.o -c code.cc
        !g++ $(gtest-config --cppflags --cxxflags) -o unittests.o -c unittests.cc
        silent !rm ./unittests
        !g++ $(gtest-config --ldflags --libs) -o unittests ../_test_cc_gtest/gtest_main.o code.o unittests.o
        !./unittests
        silent !rm ./unittests
        silent !rm *.o
    endif

    execute "cd " . cwd
endfunction

" Installation Notes:
" While trying to get the samples to work I needed to add /usr/local/lib to
" the ld configuration.  I used the following command:
" sudo bash -c 'echo /usr/local/lib >> /etc/ld.so.conf ' &&  sudo ldconfig
" which was talked about in greater detail here:
" http://groups.google.com/group/googletestframework/browse_thread/thread/871aeeca486073b3