# playwright-k8s

Demo of how to run playwright tests in a kubernetes cluster. Work in progress

- Autoscaling
- Batch jobs with Argo Workflows
- GCP and AWS provisioning with Terraform
- Playwright Dockerfile

To do
- Reporting/Report merging via Playwright
- Pushing report to storage bucket and publishing it to private webpage
- Ready-to-use Terraform projects for GCP, AWS, and Azure
   - Private endpoint option
   - Size options
   - Resource options 
- Alternative method for batch jobs using deployments
- More complete documentation of processes and a references section

# Getting Started

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Clone this repository](https://github.com/aaron-smits/playwright-k8s)

## Deploying to GCP

1. Authenticate with GCP

``` bash
gcloud auth application-default login
```

This will open a web browser and ask you to authenticate with GCP. Once you have authenticated, you can close the browser window.


2. Initialize Terraform

``` bash
cd gcp
terraform init
```

3. Apply Terraform

``` bash
terraform apply
```

This will run for a few minutes and output a connection command so you can access the control plane.

4. Connect to the control plane

``` bash
gcloud container clusters get-credentials pw-k8s --region <your-region> --project <your-project>
```

You can check the nodes quickly just to make sure you're connected:

``` bash
kubectl get nodes
```


5. Push your image to GAR

Give your user permission to push to the GAR:

``` bash
gcloud projects add-iam-policy-binding <your-project-name> \                                 
   --member=user:<your-email> \
   --role=roles/artifactregistry.admin
```

Add the registry to your Docker config:

``` bash
gcloud auth configure-docker \
    <your-region>-docker.pkg.dev
```

Then, build and push the image:

``` bash
docker build -t pw-k8s:latest .
docker tag pw-k8s:latest <your-region>-docker.pkg.dev/<your-project>/pw-k8s/pw-k8s:latest
docker push <your-region>-docker.pkg.dev/<your-project>/pw-k8s/pw-k8s:latest
```

The sample Dockerfile is located in the root of this repository. It is based on the [official Playwright Docker image](https://hub.docker.com/_/microsoft-playwright)

It copys in your tests folder, config file, and package.json, then runs `npm install`. There is no command specified, so you will need to specify the command when you run the container.


6. Setup argo

Get the latest version of the CLI and controller/server from the [releases page](https://github.com/argoproj/argo-workflows/releases/latest)

``` bash
kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/<your-version>/install.yaml
```

Run the argo server in another terminal window:

``` bash
kubectl port-forward deployment/argo-server -n argo 2746:2746
```

It will be available at https://localhost:2746

You will be prompted for a login, you can create a token with the following commands:

Create a Kubernetes role in the argo namespace
``` bash
kubectl apply -n argo -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: argo-acct
  namespace: argo
rules:
- apiGroups:
  - ""
  resources:
  - events
  - pods
  - pods/log
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - argoproj.io
  resources:
  - eventsources
  - sensors
  - workflows
  - workfloweventbindings
  - workflowtemplates
  - clusterworkflowtemplates
  - cronworkflows
  - cronworkflows
  - workflowtaskresults
  verbs:
  - get
  - list
  - watch
EOF
```

Create a service account in the argo namespace
``` bash
kubectl create -n argo sa argo-acct  
kubectl create -n argo rolebinding argo-acct --role=argo-acct --serviceaccount=argo:argo-acct
```

Create a token for the service account
``` bash
kubectl apply -n argo -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: argo-acct.service-account-token
  annotations:
    kubernetes.io/service-account.name: argo-acct
type: kubernetes.io/service-account-token
EOF
```

Get the token
``` bash
ARGO_TOKEN="Bearer $(kubectl get -n argo secret argo-acct.service-account-token -o=jsonpath='{.data.token}' | base64 --decode)"
echo $ARGO_TOKEN
Bearer ZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkltS...
```

Back at https://localhost:2746, you can now login with the token.


Revoke the token if needed with
``` bash
kubectl delete secret $SECRET
```

Verify everything is working with
``` bash
kubectl get all -n argo
```

7. Submit a workflow

For a quick test, you can run an example workflow:
``` bash
argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/master/examples/hello-world.yaml
```

After it's done, you can get the logs:
``` bash
argo logs -n argo @latest
```

To list all workflows:
```
argo list -n argo
```

To delete the workflow you just ran:
```
argo delete -n argo @latest
```

8. Submit the playwright workflow

Please note that you will need to update this file to use your own docker image. You can pull it from a public Docker Hub repo or set up your own repo using your cloud provider.  

Create an argo admin
```
kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=argo:default --namespace=argo
```
Run the workflow
```
argo submit -n argo --watch k8s/argo/pw.yaml
```

# Issues, Suggestions, and Contributions
Please let me know if you have any feedback or would like to contribute to this project. My aim is to assemble a solution for this using open source tools and make this setup accessible to anyone. Email: aaronsmitstc@gmail.com
