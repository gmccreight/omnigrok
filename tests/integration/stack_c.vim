source helpers/setup.vim

call StartTapWithPlan(1)

cd ../../

source rosetta_cs.vim
edit stack_c/code.c

silent call RunUnitTestsForDir()

cd tests/integration
read tmp_tests_out.txt

call vimtap#Like(BufferContent(), '100%: Checks', 'Passed all its tests')

source helpers/teardown.vim