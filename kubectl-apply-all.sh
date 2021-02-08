#!/bin/bash
#
# This file should contain `kubectl apply` commands for all of your configured resources.
#
# This file should be run:
#   * When the cluster is first created
#   * Whenever the configuration for any resource has been updated
#
# The --prune flag is destructive and should always be used
# in conjunction with -f base and -l deploy=sourcegraph. Otherwise, it will delete all resources
# previously created by create or apply that are not specified in the command.
#
# Apply the base Sourcegraph deployment
# shellcheck disable=SC2068

# https://docs.sourcegraph.com/admin/install/kubernetes/configure#using-networkpolicy
kubectl create namespace ns-sourcegraph --dry-run=true -o yaml | kubectl apply -f -
kubectl label namespace ns-sourcegraph name=ns-sourcegraph

kubectl apply --prune -l deploy=sourcegraph -f generated-cluster --validate=false --recursive $@

# When running locally or without vault -- uncomment
# resources:gitserver/gitserver.ExternalSecret.yaml in overlays/custom/kustomization.yaml
# # This is for using a local ssh key instead of one stored in vault
# BUILD_DIR=$(mktemp -d)
# export BUILD_DIR

# cleanup() {
#   rm -rf "${BUILD_DIR}"
# }
# trap cleanup EXIT

# ssh-keyscan github.com >"${BUILD_DIR}/known_hosts"

# kubectl create secret generic -n ns-sourcegraph gitserver-ssh \
#   --from-file id_rsa=${HOME}/.ssh/id_rsa_passwordless \
#   --from-file known_hosts="${BUILD_DIR}/known_hosts"
