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
        elseif match(dir, "_scala$") > 0
            " It's a Scala directory
            let fname = fname . ".scala"
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

" Directories have a standard structure, it's easy to run the unit tests.
function! RunUnitTestsForDir()
    write
    let dir = expand("%:h")
    let current_file = expand("%")
    if match(current_file, "practice") > 0
      exec "!./_app/runner.rb run_practice " . dir
    else
      exec "!./_app/runner.rb run_normal " . dir
    endif
endfunction
