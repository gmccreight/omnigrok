source _app/omnigrok.vim

"Show the instructions in a split window
edit _app/sandboxes/instructions.txt

"Open the NERDTree and the top-level main categories
NERDTree
/data_structures
normal o
/algorithms
normal o
nohls
