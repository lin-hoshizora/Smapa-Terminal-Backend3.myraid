sudo docker run -d --restart=always -v /home/smapa/Smapa-Terminal-Backend/ori_img:/app/ori_img --net=host st-backend-web:1.0 /bin/bash -c "cd /app && python3 server.py"
