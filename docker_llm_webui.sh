#!/bin/bash

echo '     ____                               _____                                       .___'
echo '    |    |____    __________   ____     /     \ _____  ___.__. ____ _____ _______  __| _/'
echo '    |    \__  \  /  ___/  _ \ /    \   /  \ /  \\__  \<   |  |/    \\__  \\_  __ \/ __ |'
echo '/\__|    |/ __ \_\___ (  <_> )   |  \ /    Y    \/ __ \\___  |   |  \/ __ \|  | \/ /_/ |'
echo '\________(____  /____  >____/|___|  / \____|__  (____  / ____|___|  (____  /__|  \____ |'
echo '              \/     \/           \/          \/     \/\/         \/     \/           \/'
echo 

echo 'running apt update'
sudo apt update   
echo 'installing docker'
sudo apt install -y docker.io
echo 'allow current user to run docker'
sudo usermod -aG docker $USER
read -p "CPU Only (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo 'CPU ONLY Docker with Ollama Installed'
  docker run -d -p 3000:8080 -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
else
  echo 'NIVIDIA GPU Powered Docker with Ollama Installed'
  docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
fi
