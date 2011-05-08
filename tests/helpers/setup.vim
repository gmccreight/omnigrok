function! StartTapWithPlan(plan)
    silent !rm tmp_tests_out.txt
    call vimtest#StartTap()
    call vimtap#Plan(a:plan)
endfunction

function! LineContent()
    normal "ayy
    return getreg('a')
endfunction

function! BufferContent()
    normal ggVG"ayy
    return getreg('a')
endfunction
