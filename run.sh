#!/bin/sh
#And now run the container
docker build . -t demo
docker run -d -p 8887:8887 --pid="host" --privileged demo
./curl_it.sh
docker kill demo
