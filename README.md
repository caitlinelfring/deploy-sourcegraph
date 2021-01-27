# Sourcegraph on Kubernetes

This is instructions for setting up Souregraph with customizations using `kustomize`.

For Sourcegraph's documentation/README, see [README.sourcegraph.md](README.sourcegraph.md)

```bash
# Generate using kustomize overlays
./overlay-generate-cluster.sh custom generated-cluster

# This will output all the kubernetes resources to `./generated-cluster` directory (git-ignored)
# To deploy these resources:
./kubectl-apply-all.sh
```
