# This command will execute all docker files of the project
docker-compose $(find docker-compose* | sed -e 's/^/-f /') up -d