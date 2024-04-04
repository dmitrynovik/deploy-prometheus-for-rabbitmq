
#!/bin/bash  
set -eo pipefail

grafana_namespace=grafana
grafana_chart_name=rabbitmq-grafana

# Uncomment the below to create Prometheus k8s operator (first install only):
# echo "Deploying Prometheus k8s operator"
# sudo kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml

echo "Creating Prometheus ServiceAccount, ClusterRole and ClusterRoleBinding"
sudo kubectl apply -f prom_rbac.yaml

echo "Creating Prometheus ServiceMonitor"
sudo kubectl apply -f prom_svc_monitor.yaml

echo "Creating Prometheus Service"
sudo kubectl apply -f prom_svc.yaml

echo "Creating Prometheus RabbitMQ service monitor"
sudo kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/observability/prometheus/monitors/rabbitmq-servicemonitor.yml

echo "Installing Grafana into the namespace: $grafana_namespace"
sudo helm repo add grafana https://grafana.github.io/helm-charts
sudo helm repo update
sudo kubectl create namespace $grafana_namespace --dry-run=client -o yaml | sudo kubectl apply -f-
sudo helm install $grafana_chart_name grafana/grafana --namespace $grafana_namespace



