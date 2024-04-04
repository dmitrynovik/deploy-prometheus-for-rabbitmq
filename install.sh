
echo "Deploying Prometheus k8s operator"
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml

echo "Creating ServiceAccount, ClusterRole and ClusterRoleBinding"
kubectl apply -f prom_rbac.yaml

echo "Creating ServiceMonitor"
kubectl apply -f prom_svc_monitor.yaml

echo "Creating Service"
kubectl apply -f prom_svc.yaml

echo "Creating RabbitMQ service monitor"
kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/observability/prometheus/monitors/rabbitmq-servicemonitor.yml
