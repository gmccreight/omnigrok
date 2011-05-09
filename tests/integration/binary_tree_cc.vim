source helpers/setup.vim

call StartTapWithPlan(1)

cd ../../

source rosetta_cs.vim
edit binary_tree_cc/code.cc

silent call RunUnitTestsForDir()

cd tests/integration
read tmp_tests_out.txt

call vimtap#Like(BufferContent(), 'PASSED', 'Passed all its tests')

source helpers/teardown.vim
