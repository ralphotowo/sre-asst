# Ecosia: Site Reliability Engineering Assignment

This is my attempt to satisfy the requirements of the Lead SRE assignment for Ecosia. 

### Execute Shell Script
1. Clone this repository and change directory into it
2. Grant the build.sh script execute permissions (`chmod +x build.sh`)
3. Execute the script on a machine with minikube installed: `./build.sh`

### Overview

The following is an overview of the various components:
- **server.js**: A web server written in node.js 
    - Requires the HTTP function and establishes a conditional to respond to /tree
    - Sets the application header to application/json
    - Responds to a GET query at /tree with the requested JSON output
- **Dockerfile**: Responsible for building the image
    - Copies server.js into the work directory
    - Creates and switches to a node user
    - Installs dumb-init to act as an init process to handle `SIGTERM` and `SIGKILL` signals
- **build.sh**: Responsible for building the image
    - Locates required binaries and maps them to variables
    - Ensures minikube is running on the local workstatation
    - Initializes the minikube docker-env to ensure built images are stored within the Minikube VM
    - Builds the docker image and tags it
    - Applies the relevant manifest files under the k8s's directory. 

**Note**: This implementation exposes the node app using both a service and an ingress. Following successful execution of the script, an IP address will be returned which can be used to view the JSON output immmediately. A local DNS map has to be established at /etc/hosts using the IP address returned from `kubectl get ingress`
