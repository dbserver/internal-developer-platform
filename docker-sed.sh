# example
# docker-compose -f docker-compose.db.yml \
#   -f docker-compose.api-services.yml \
#   -f docker-compose.backend.yml \
#   -f docker-compose.frontend.yml \
#   -f docker-compose.gateway.yml \
#   up -d

docker-compose $(find docker-compose* | sed -e 's/^/-f /') up -d