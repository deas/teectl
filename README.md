# An OCI Image for the Traefik Enterprise CLI teectl

[![test](https://github.com/deas/teectl/workflows/test/badge.svg)](https://github.com/deas/teectl/blob/main/.github/workflows/test.yml)
[![cve-scan](https://github.com/deas/teectl/workflows/cve-scan/badge.svg)](https://github.com/deas/teectl/blob/main/.github/workflows/cve-scan.yml)

Disclaimer: Functionality provided here should probably be shipped with the core Taefik Enterprise product. In fact, it might already. The author barely knew the product at the time of writing. Hence, some things appear hacky or oddly implemented.

`deas/teectl` is an OCI Image for the Traefik Enterprise CLI tool [`teectl`](https://doc.traefik.io/traefik-enterprise/installing/kubernetes/teectl/) - mostly aimed at GitOps automation around setup, backup, restore ... you name it. The vendor appears to be [targeting GitOps](https://doc.traefik.io/traefik-enterprise/installing/kubernetes/gitops/) - still, we did not find what we whre looking for. So here we are.

It starts with `teectl`. We want it executing in a container.

## Usage
You can run the `teectl` container barely on your local machine (requires local `teectl-config.yaml`):

```shell
docker run -rm --it -v $HOME/.kube:/kube deas/teectl:latest get nodes
```

An example for GitOps automation including a custom private plugin is provided as an [`example`](/example).

## Build
```
docker build --build-arg TEE_VERSION=v2.8.0 --tag ghcr.io/deas/teectl:latest .
```

## TODO
- GH Actions release
