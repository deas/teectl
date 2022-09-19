#!/bin/sh
if [ -n "${KUBERNETES_SERVICE_HOST}" ] ; then
    echo "Initializing pod-context with HOME=$HOME"
    kubectl config set-cluster the-cluster --server="https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT}" --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    kubectl config set-credentials pod-token --token="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"
    kubectl config set-context pod-context --cluster=the-cluster --user=pod-token
    kubectl config use-context pod-context
fi

exec /teectl "$@"