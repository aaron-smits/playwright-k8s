# Works consulted:
https://kubernetes.io/docs/tasks/job/parallel-processing-expansion/
https://www.digitalocean.com/community/tutorials/how-to-run-end-to-end-tests-using-playwright-and-docker
https://playwright.dev/docs/test-sharding
https://playwright.dev/docs/test-cli#reference
https://kubernetes.io/blog/2021/04/19/introducing-indexed-jobs/
https://github.com/Neutrollized/free-tier-gke
https://cloud.google.com/compute/docs/instances/preemptible
https://hub.docker.com/repository/docker/aaronsmits/pw-k8s/general
https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke

https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

Argo Workflows for Kubernetes
https://argoproj.github.io/argo-workflows/

AWS EKS Tutorial with Terrform Modules
https://antonputra.com/amazon/create-eks-cluster-using-terraform-modules/#create-eks-using-terraform
https://aws.amazon.com/blogs/compute/scaling-your-applications-faster-with-ec2-auto-scaling-warm-pools

To Do:
Research:
- [x] Argo Workflows for Kubernetes
- [x] Calculate the cost of running the cluster and the tests
- [x] pulling images from private registry
Features:
- [ ] Created shared volume for test results/artifacts
  - [ ] do this with Argo
- [ ] Create custom playwright reporter with option to upload to storage bucket and write json to a database
- [ ] Create a test publish job that pushes the test results to a web server
- [ ] Store test results in a storage bucket
- [ ] Create a frontend to display the test results over time
Write Up:
- [x] Write up the process of creating the cluster
  - [x] GKE
  - [] EKS
- [ ] Write up the process of creating the job
  - Docker
  - Playwright
  - Kubernetes
- [ ] Write up the process of running the tests in parallel
  - Playwright
  - Kubernetes
- [ ] Write up the process of creating an Argo workflow
  - Kubernetes
  - Argo
  - Argo Server
  - Argo CLI
  - Argo UI
