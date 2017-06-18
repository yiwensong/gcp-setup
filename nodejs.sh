#!/bin/sh
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm -g install gdax
sudo npm -g install cassandra-driver
sudo npm -g install fs
