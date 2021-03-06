#!/bin/bash
registry='localhost:5000'
name='covid19'
curl -v -sSL -X DELETE "http://${registry}/v2/${name}/manifests/$(
    curl -sSL -I \
        -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        "http://${registry}/v2/${name}/manifests/$(
            curl -sSL "http://${registry}/v2/${name}/tags/list" | jq -r '.tags[0]'
        )" \
    | awk '$1 == "Docker-Content-Digest:" { print $2 }' \
    | tr -d $'\r' \
)"

# tag='latest'
# curl -X DELETE -sI -k "https://${registry}/v2/${name}/manifests/$(
#   curl $auth -sI -k \
#     -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
#     "https://${registry}/v2/${name}/manifests/${tag}" \
#     | tr -d '\r' | sed -En 's/^Docker-Content-Digest: (.*)/\1/pi'
# )"