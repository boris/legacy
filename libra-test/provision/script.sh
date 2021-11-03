#!/bin/bash
sudo apt-get update
sudo apt-get -y install build-essential

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
