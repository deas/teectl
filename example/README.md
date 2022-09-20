# Traefik GitOps Demo leveraging teectl for a private Plugin

Ensure you have `secret-example-license.yaml` and `secret-aws-env.yaml` in place.

Build infra
```shell
make test-integration
```

Validate/use traefik locally
```shell
make import
cluster_name=example
teectl get static-config -cluster ${cluster_name}
teectl get nodes -cluster ${cluster_name}
teectl get plugins -cluster ${cluster_name}
```

To access the proxy service from your local machine, you might want to add an implementation of a LoadBalancer:

```shell
make apply-lb
lb_ip=$(kubectl -n traefikee get svc/example-proxy-svc -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
# Should give 404
curl http://${lb_ip}
```

Deployment of custom resources should be working from now on.

You may want to try a demo of a password protected dashboard
```shell
make apply-custom
# Should give the dashboard homepage
curl -u admin:admin http://${lb_ip}/dashboard/
```
Or using newman:
```shell
make test-e2e
```

## TODO
- RBAC: Fix abuse of (convenient) `default` `ServiceAccout`?
- This GitOps Deployment appears very hard/hacky. Specifically around plugins and the static config. Should vendor take over?
- Properly automation around Docker IPAM for LB
- Implement `helm` (hooks)? Maybe ...
- `flux 0.33.0` image: `/bin/sh: can't create teectl-config.yaml: Permission denied` - Just cosmetics. It does not matter in flux deployment env
