"If you want to do additional debugging, you can comment these two commands
"out and see what's in the .msgout and .tap files
silent !rm *.msgout
silent !rm *.tap

call vimtest#Quit()
