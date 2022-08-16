#!/bin/bash
docker run -d -p 5000:5000 -v reg:/var/lib/registry --name registry registry:2
docker ps | grep registry
