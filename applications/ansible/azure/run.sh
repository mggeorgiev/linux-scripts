#!/bin/bash

docker build . -t azAnsible
docker run -it azAnsible