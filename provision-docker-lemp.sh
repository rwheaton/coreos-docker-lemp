echo ":: Ensuring that docker is running..."
sudo systemctl start docker

echo ":: Building docker containers..."
docker build -t docker-lemp /home/core/sites/
