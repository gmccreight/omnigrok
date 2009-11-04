" Using Googletest, Google's C++ testing framework, version 1.4.0

" Don't reload the NERDTree and grep options...
if !exists('g:interviews_loaded')
    let g:interviews_loaded = 1

    " Set the EasyGrep options
    let g:EasyGrepRecursive = 1
    source $HOME/.vim/plugin/EasyGrep.vim
    " Set user-defined files for grepping
    execute "normal \\vojjj\<cr>*.cc *.h\<cr>q"

    " Open NERDTree
    NERDTree
    /binary_tree
    normal o
    nohls
endif

" Switch to the buffer if it is open, otherwise 'edit' the file
function! BufferOrEdit(filename)
    if bufexists(a:filename)
        execute "buffer " . a:filename
    else
        execute "edit " . a:filename
    endif
endfunction

" Since every folder has a standard structure, it's easy to bounce between the
" files.
map ,t :call BufferOrEdit(expand("%:h") . "/unittests.cc")<cr>
map ,c :call BufferOrEdit(expand("%:h") . "/code.cc")<cr>
map ,h :call BufferOrEdit(expand("%:h") . "/code.h")<cr>

map <c-j> :call RunUnitTestsForDir()<cr>

" If directories have a standard structure, it's easy to run the unit tests
" in them.  See the 'linked_list' directory for an example.
function! RunUnitTestsForDir()
    let cwd = getcwd()
    let dir = expand("%:h")
    execute "cd " . dir

    " If it's a c++ test
    if match(dir, "_cc$") > 0
        write
        silent !rm *.o
        !g++ -o code.o -c code.cc
        !g++ $(gtest-config --cppflags --cxxflags) -o unittests.o -c unittests.cc
        silent !rm ./unittests
        !g++ $(gtest-config --ldflags --libs) -o unittests ../_gtest_shared/gtest_main.o code.o unittests.o
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
