#!/bin/bash
smapa_base_path=$1
user=$2
sudo mkdir -p /home/$user/

sudo cp -r $1 /home/$user/

sudo ln -s /home/$user/Smapa-Terminal-Backend3 /home/$user/Smapa-Terminal-Backend2

sudo ln -s /home/$user/Smapa-Terminal-Backend3 /home/$user/Smapa-Terminal-Backend

