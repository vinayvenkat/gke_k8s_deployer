# gke_k8s_deployer
Set of scripts to easily deploy a k8s cluster on GKE

The following steps can be followed to deploy a K8's cluster on GKE:

Pre-requisites:

1. gcloud cli has been installed on your machine.

Steps:

1. Run ```manage_k8s_cluster.sh``` 

   ``` ./manage_k8s_cluster.sh create <cluster name> <GCP zone> <GCP project id> ```

2. Run ```bash get-creds.sh```

   ``` ./get-creds.sh <cluster name> <GCP zone> <GCP project id> ```

3. Run ```cluster-role.sh```

  ``` ./cluster-role.sh ```

4. Download and install the latest version of Istio.

   Link: https://istio.io/docs/setup/kubernetes/download-release/

5. Edit the istio-cfg.sh file set the directory path to the Istio installation

6. Run ```istio-cfg.sh```

   ``` ./istio.cfg.sh install_crds ```

7. Run ```instio-cfg.sh``` again with the following arguments.

   ``` ./istio-cfg.sh create_namespace <namespace name> ```

   Note this is the namespace that will introduce the injection of the Envoy proxy.

Please refer to the ```Kubernetes_and_Istio_Instructions.txt``` document for additional notes.
