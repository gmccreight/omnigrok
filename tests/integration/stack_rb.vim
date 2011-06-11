source helpers/setup.vim

call StartTapWithPlan(1)

cd ../../

source rosetta_cs.vim
edit stack/stack_rb/code.rb

silent call RunUnitTestsForDir()

cd tests/integration
read tmp_tests_out.txt

call vimtap#Like(BufferContent(), '0 failures, 0 errors', 'Passed all its tests')

source helpers/teardown.vim
