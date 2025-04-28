sudo apt update
sudo apt install -y fontconfig openjdk-21-jre docker.io git

sudo groupadd jenkins
sudo useradd jenkins -g jenkins -m  
sudo usermod jenkins -aG docker
