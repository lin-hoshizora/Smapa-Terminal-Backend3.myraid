#!/bin/bash

IMG_FOLDER=$HOME/Smapa-Terminal-Backend3/ori_img
if [ ! -d $IMG_FOLDER ]
then
echo "Image folder $IMG_FOLDER does not exist, creating a new one..."
mkdir $IMG_FOLDER
fi

DATA_FOLDER=$HOME/Smapa-Terminal-Backend3/backend_res
if [ ! -d $DATA_FOLDER ]
then
echo "WS data folder $DATA_FOLDER does not exist, creating a new one..."
mkdir $DATA_FOLDER
fi

CONFIG_FOLDER=$HOME/Smapa-Terminal-Backend3/config

echo "Starting model_server"
#sudo docker run -d -v $CONFIG_FOLDER:/app/config -v /dev:/dev --privileged --network=host --restart=unless-stopped model_server:2.0

echo "Starting scanner"
#sudo docker run -d -v $IMG_FOLDER:$IMG_FOLDER -v $CONFIG_FOLDER:/app/config -v /dev:/dev --privileged --network=host --restart=unless-stopped scanner:1.0

echo "Starting smapa backend"
sudo docker run -d -v $DATA_FOLDER:$DATA_FOLDER -v $IMG_FOLDER:$IMG_FOLDER -v $CONFIG_FOLDER:/app/config -v /var/run/docker.sock:/var/run/docker.sock --privileged --restart=unless-stopped --network=host smapa_backend:2.1
