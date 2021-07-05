#!/bin/bash

model_server_tag="2.0"
scanner_tag="1.0"
smapa_backend_tag="2.2"
st_backend_web_tag="1.0"

image_path=$1

# sudo docker stop $(sudo docker ps -q)
sudo docker stop $(sudo docker ps | awk '/(smapa_backend:.*|model_server:.*|scanner:.*|st-backend-web:.*)/{print $1}') 

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
#sudo docker run -d -v $CONFIG_FOLDER:/app/config -v /dev:/dev --privileged --network=host --restart=unless-stopped model_server:$model_server_tag

echo "Starting scanner"
# sudo docker run -d -v $IMG_FOLDER:$IMG_FOLDER -v $CONFIG_FOLDER:/app/config -v /dev:/dev -v /ori_img:/ori_img --privileged --network=host  scanner:$scanner_tag
# sudo docker run -d -v $HOME/Smapa-Terminal-Backend3/ori_img:$HOME/Smapa-Terminal-Backend3/ori_img -v $HOME/Smapa-Terminal-Backend3/config:/app/config -v /dev:/dev -v /ori_img:/ori_img --privileged --network=host  scanner:1.0 bash -c "export SCANNER=0;/app/entrypoint.py"
# sudo docker run -d -v $HOME/Smapa-Terminal-Backend3/ori_img:$HOME/Smapa-Terminal-Backend3/ori_img -v $HOME/Smapa-Terminal-Backend3/config:/app/config -v /dev:/dev -v /ori_img:/ori_img --privileged --network=host  scanner:1.0 bash -c "/app/entrypoint.py"
echo "Starting smapa backend"
sudo docker run -d -v $HOME/Smapa-Terminal-Backend3/ocr2:/app/ocr2 -v /ori_img:/ori_img -v $DATA_FOLDER:$DATA_FOLDER -v $IMG_FOLDER:$IMG_FOLDER -v $CONFIG_FOLDER:/app/config -v /var/run/docker.sock:/var/run/docker.sock --privileged --restart=unless-stopped --network=host smapa_backend:$smapa_backend_tag

sudo docker run -d --restart=always -v $image_path:$image_path -v /home/smapa/Smapa-Terminal-Backend/ori_img:/app/ori_img --net=host st-backend-web:$st_backend_web_tag /bin/bash -c "cd /app && python3 server.py"


