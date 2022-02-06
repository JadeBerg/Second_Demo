# Docker app

## Here we have our Dockerfile:

```
FROM nginx:latest
COPY app/ /usr/share/nginx/html/
EXPOSE 80
```

## And Makefile for local build our image:

```
REPO_NAME = $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com/${APP_NAME}

.PHONY: build
build:
	aws ecr get-login-password --region $(REPOSITORY_REGION) | docker login --username AWS --password-stdin $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com
	docker build -t $(REPO_NAME):$(TAG) .
	docker push $(REPO_NAME):$(TAG)
```