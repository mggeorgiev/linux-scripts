#!/bin/bash
cat > ~/my-registries.yaml << EOF
mirrors:
  "d-infra.sofia:5000":
    endpoint:
      - http://d-infra.sofia:5000
EOF