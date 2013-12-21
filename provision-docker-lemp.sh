echo ":: Ensuring that docker is running..."
sudo systemctl start docker

echo ":: Building docker containers..."
docker build -t docker-lemp /home/core/sites/

echo ":: Starting docker-lemp..."
docker run -p 8080:80 -i -t docker-lemp