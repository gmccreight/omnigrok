#!/bin/sh
#----------------------------------------------------------------------------
# gtest, which is used for C++ code
wget http://googletest.googlecode.com/files/gtest-1.4.0.tar.gz
rm -rf gtest-1.4.0
tar -xvzf gtest-1.4.0.tar.gz
cd gtest-1.4.0
./configure
make
sudo make install
# Need to add /usr/local/lib to the ld configuration. For more info:
# http://groups.google.com/group/googletestframework/browse_thread/thread/871aeeca486073b3
sudo bash -c 'echo /usr/local/lib >> /etc/ld.so.conf ' &&  sudo ldconfig

cd ../
rm -rf gtest-1.4.0
