#!/bin/bash

image_tag = $1

image_sha=$(docker build -q .)

docker tag $image_sha $image_tag
docker push $image_tag

