# Works consulted:
https://kubernetes.io/docs/tasks/job/parallel-processing-expansion/
https://www.digitalocean.com/community/tutorials/how-to-run-end-to-end-tests-using-playwright-and-docker
https://playwright.dev/docs/test-sharding
https://playwright.dev/docs/test-cli#reference
https://kubernetes.io/blog/2021/04/19/introducing-indexed-jobs/
https://github.com/Neutrollized/free-tier-gke
https://cloud.google.com/compute/docs/instances/preemptible
https://hub.docker.com/repository/docker/aaronsmits/pw-k8s/general


# Playwright Kubernetes
To Do:
- [ ] Add a test that fails
- [ ] Add a test that fails and is flaky
- [ ] Created shared volume for test results
- [ ] Create a test publish job that pushes the test results to a web server
- [ ] Create a test report job that generates a report from the test results
- [ ] Store test results in a storage bucket
- [ ] Create a frontend to display the test results over time