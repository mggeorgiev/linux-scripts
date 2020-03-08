#!/bin/bash

microk8s.enable dns dashboard ingress

ifconfig

microk8s.kubectl proxy --accept-hosts=.* --address=0.0.0.0 &
