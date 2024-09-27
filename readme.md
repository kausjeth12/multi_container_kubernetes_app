# How to setup deployment

## Google cloud setup

1. Create Project
2. Enable kubernetes API from project dashboard
3. Create kubernetes cluster
4. Maintain Travis yaml file or as per the deployment environment
5. Create Service account from IAM & Admin section and assign role as kubernetes engine admin, after that create a key and download it as json and keep it at safe place.

## Create encrypted file of service account

1. Installing ruby is cumbersome task, so will do using docker image
2. Run command: docker run -it -v $(pwd):/app ruby:<latest_version> sh
3. gem install travis
4. travis login --github-token <token>
5. travis encrypt-file <service_account.json> -r <git_username>/<repo_name> and follow the step mentioned on the screen.
6. **Note!!! ---> Remove the actual file of service account from directory**

## Travis configurations

1. Go ahead with further configurations in travis.yaml file
2. Add docker username and password in travis project environment
3. Go ahead with further configurations in travis.yaml file

## Google cloud configurations

1. If inside google cloud console of cluster not properly configured then run below three commands:
   1. gcloud config set project <project_name>
   2. gcloud config set compute/zone <zone>
   3. gcloud container clusters get-credentials <cluster_name>
2. Create require secrets on kubernetes cluster
   1. kubectl create secret generic <secret_name> --from-literal <**key**>=<**value**>

## Install ingress nginx service

Perform this task on kubernetes cluster cloud shell

1. Install using ingress-nginx
   1. Open: https://kubernetes.github.io/ingress-nginx and click deployment and follow the steps to install ingress with specific environment.
2. Install using helm
   1. Open : https://docs.helm.sh/docs/intro/install/
   2. Run: helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
   3. Run: kubectl get service ingress-nginx-controller --namespace=ingress-nginx
3. Once ingress-nginx-controller installed, add IP to the domain registart site against domain name.

## Install Cert manager using helm

1. Run: helm repo add jetstack https://charts.jetstack.io
2. Run: helm repo update
3. Run: helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.12.0 --set installCRDs=true --debug
