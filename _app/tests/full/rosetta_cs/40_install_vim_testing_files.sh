#All the vim test stuff
sudo cp -a _app/tests/integration/files_to_copy_to_usr_local_bin/* /usr/local/bin

mkdir ~/.vim

#Install runVimTests
wget -O ~/.vim/runvimtests.zip http://www.vim.org/scripts/download_script.php?src_id=15135
cd ~/.vim
unzip runvimtests.zip
cd runVimTests*
cp -a * ../
cd ..
rm -r runVimTests*
rm runvimtests.zip

##Install vimtap
wget -O ~/.vim/vimtap.zip http://www.vim.org/scripts/download_script.php?src_id=10071
cd ~/.vim
unzip vimtap.zip
cd VimTAP*
cp -a * ../
cd ..
rm -r VimTAP*
rm vimtap.zip
