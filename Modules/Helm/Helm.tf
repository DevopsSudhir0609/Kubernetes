terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}
provider "azurerm" {
  features {}
    subscription_id = "5fc983dd-0425-421b-af56-35481b3c92d4"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "null_resource" "kube_config" {
  provisioner "local-exec" {
    command = <<EOF
az aks get-credentials \
--resource-group project-Alpha \
--name cluster1 \
--overwrite-existing
EOF
  }
}

resource "helm_release" "argocd" {
  depends_on = [null_resource.kube_config]

  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.8"
  namespace  = "argocd"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  # Recommended additional settings
  set {
    name  = "server.extraArgs[0]"
    value = "--insecure"  # Disables TLS for easier testing
  }

  set {
    name  = "controller.replicas"
    value = "2"  # For high availability
  }
}

output "argocd_info" {
  value = <<EOT
ArgoCD installed successfully!

1. Get the admin password:
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

2. Access methods:
   - LoadBalancer IP: kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
   - Port-forward: kubectl port-forward svc/argocd-server -n argocd 8080:443
     Then open: https://localhost:8080

3. Login with:
   Username: admin
   Password: [from step 1]
EOT
}