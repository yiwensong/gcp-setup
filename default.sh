sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git

ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

git clone https://github.com/yiwensong/gcp-setup.git ~/gcp-setup
cd ~/gcp-setup
sh unzip.sh
cd ~
rm -rf ~/gcp-setup
