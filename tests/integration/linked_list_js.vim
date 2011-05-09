source helpers/setup.vim

call StartTapWithPlan(1)

cd ../../

source rosetta_cs.vim
edit linked_list_js/code.js

silent call RunUnitTestsForDir()

cd tests/integration
read tmp_tests_out.txt

call vimtap#Like(BufferContent(), 'ALL TESTS PASSED', 'Passed all its tests')

source helpers/teardown.vim
