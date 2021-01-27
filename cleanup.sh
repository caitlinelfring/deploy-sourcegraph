#!/usr/bin/env bash

set -euf -o pipefail

kubectl delete -l deploy=sourcegraph -f generated-cluster --recursive $@
kubectl delete namespace ns-sourcegraph
