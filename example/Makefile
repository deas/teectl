K8S_VERSION=v1.22.13
CLUSTER_NAME=example

.PHONY: test-integration 

release.yaml:
	helm template --release-name traefikee traefikee/traefikee --namespace traefikee -f traefikee-values.yaml > release.yaml

apply-lb:
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.5/config/manifests/metallb-native.yaml
	sleep 20
	kubectl -n metallb-system wait --timeout=180s --for=condition=ready pod -l app=metallb,component=controller
	docker network inspect --format '{{ json (index .IPAM.Config 0) }}' kind | jq -r .Subnet 
	kubectl apply -f metallb-config.yaml

apply-custom:
	kustomize build custom | kubectl apply -f -

test-integration: release.yaml
	kind create cluster --image kindest/node:$(K8S_VERSION)
	kustomize build .  | kubectl apply -f -

test-e2e:
	docker run --network host -v`pwd`/collections:/etc/newman -t postman/newman run /etc/newman/sample.json

teectl-import:
	kubectl exec -n traefikee ${CLUSTER_NAME}-controller-0 -- /traefikee generate credentials \
    	--kubernetes.kubeconfig="$${HOME}/.kube/config"  --cluster=${CLUSTER_NAME} > teectl-config-${CLUSTER_NAME}.yaml
	# TODO: Use the teectl docker image instead
	teectl cluster import --force --file="teectl-config-${CLUSTER_NAME}.yaml"


