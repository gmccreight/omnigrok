sudo apt-get install unzip -y

cd ~
mkdir .vim
cd .vim

wget -O nerdtree.zip http://www.vim.org/scripts/download_script.php?src_id=11834
unzip nerdtree.zip
rm nerdtree.zip

wget -O coffeescript.zip http://www.vim.org/scripts/download_script.php?src_id=16124
unzip coffeescript.zip
rm coffeescript.zip
