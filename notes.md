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

To Do:
Research:
- [ ] Add a test that fails
- [ ] Add a test that fails and is flaky
- [ ] Helm for working with all the yaml files
Features:
- [ ] Created shared volume for test results
- [ ] Create a test publish job that pushes the test results to a web server
- [ ] Store test results in a storage bucket
- [ ] Create a frontend to display the test results over time
Write Up:
- [ ] Write up the process of creating the cluster
  - Terraform
  - GKE
- [ ] Write up the process of creating the job
  - Docker
  - Playwright
  - Kubernetes
# Commands that are useful

```bash
# Add observability to the cluster
gcloud container clusters update pw-k8s --region=us-central1 --monitoring=SYSTEM 

# Set up kubernetes dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml

# Generate credentials for kubectl with gcloud
gcloud container clusters get-credentials pw-k8s --region=us-central1-c

# Create a job
kubectl apply -f job.yaml

```