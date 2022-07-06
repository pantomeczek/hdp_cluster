#!/bin/bash

#https://linuxways.net/ubuntu/how-to-install-jupyter-notebook-on-ubuntu-20-04/

cd /home/hdoop/jupyter_dir
virtualenv jupyter_env
source jupyter_env/bin/activate
pip3 install jupyter
pip3 install findspark
jupyter notebook --p 0.0.0.0
