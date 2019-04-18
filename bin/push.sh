#!/bin/bash

IMG_TAG=$1

if [[ -z "$IMG_TAG" ]]; then
  echo "usage: ./bin/push.sh [IMAGE_TAG]"
  echo
  echo "A tool to build and push this docker container to dockerhub."
  echo "You must be authenticated with docker have have access to the repo."
  echo
  echo "Arguments:"
  echo "  [IMAGE_TAG] - The tag name you want the image to have"
else
  DOCKER_STR="minimsecure/ruby-ci-docker-image:${IMG_TAG}"

  echo "Building and $DOCKER_STR"

  docker build -t $DOCKER_STR .

  read -p "Image built! Would you like to push to dockerhub? [y/n]" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    docker push $DOCKER_STR
  fi
fi
