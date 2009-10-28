" Using Googletest, Google's C++ testing framework


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
endif

" While trying to get the samples to work I needed to add /usr/local/lib to
" the ld configuration.  I used the following command:
" sudo bash -c 'echo /usr/local/lib >> /etc/ld.so.conf ' &&  sudo ldconfig
" which was talked about in greater detail here:
" http://groups.google.com/group/googletestframework/browse_thread/thread/871aeeca486073b3
 
map <f4> :call RunUnitTestsForDir()<cr>

" If directories are layed out a special way, it's easy to run the unit tests
" in them.
function! RunUnitTestsForDir()
    let cwd = getcwd()
    execute "cd " . expand("%:h")
    !g++ -o code.o -c code.cc
    !g++ $(gtest-config --cppflags --cxxflags) -o unittests.o -c unittests.cc
    !g++ $(gtest-config --ldflags --libs) -o unittests ../_gtest_shared/gtest_main.o code.o unittests.o
    !./unittests
    execute "cd " . cwd
endfunction
