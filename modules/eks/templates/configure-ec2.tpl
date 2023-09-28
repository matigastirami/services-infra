#!/bin/bash
# Install and configure CloudWatch Logs agent
sudo yum update -y
sudo yum install -y awslogs
sudo service awslogs start
/etc/eks/bootstrap.sh ${EKS_CLUSTER_NAME} --apiserver-endpoint ${API_SERVER_URL} --b64-cluster-ca ${B64_CLUSTER_CA}