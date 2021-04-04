include .env

# Remove project Docker container, image, network, volume
clean:
	docker rm ${CONTAINER_NAME}
	docker rmi ${IMAGE_NAME}
	docker network rm ${NETWORK}

# Clean Yarn global cache
clean-yarn-cache:
	docker exec -t -i ${CONTAINER_NAME} yarn cache clean

# Rebuild Docker image and container with Docker compose
dev-rebuild:
	docker-compose -f docker-compose.yml up --detach --build

# Start Docker container with Docker compose
dev-start:
	docker-compose -f docker-compose.yml up --detach

# Build Docker image
image:
	docker build -f docker/Dockerfile -t ${IMAGE_NAME} code

# Publish Docker image to Docker Hub
publish:
	docker push ${IMAGE_NAME}:latest

# Run Docker container
serve:
	docker run -d -p 80:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}

# Access Docker container terminal.
ssh:
	docker exec -t -i ${CONTAINER_NAME} /bin/sh

# Stop Docker container
stop:
	docker stop ${CONTAINER_NAME}
