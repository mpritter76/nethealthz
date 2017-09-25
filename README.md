# nethealthz

## Description
This is a simple image built to check the healthz status of flannel or kube-proxy before starting the other. The image takes two arguments: script_name and hostname. The script_name is the reference to the what service you would like to health check along with the hostname of the node the pod is running on. The hostname is expected to be in a specific format for the purpose of extracting the IP address from the name.  Currently this only works for the DataCenter naming convention: eg. k8s-master-test-tte-10-66-56-22

## Using the image.
This script is intented to be used as an initContainer within the PodSpec for flannel or kube-proxy. The purpose of an [initContainers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) is to run before all any other containers start.


## Add initContainer to flannel OR kube-proxy PodSpec

```
  initContainers:
  - name: nethealthz
    image: mpritter76/nethealthz
    command: ['<script_name>','$POD_NODE_NAME']
    env:
      - name: POD_NODE_NAME
        valueFrom:
          fieldRef:
            fieldPath: spec.nodeName
```
* <script_name> choices:
  * flannel-healthcheck.sh
  * kube-proxy-healthcheck.sh


The initContainer takes advantage of Pod environment variables. Currently in [1.6](https://v1-6.docs.kubernetes.io/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/#the-downward-api), the Node IP address is not availble as an environment variable.

## Run Locally
```
docker run mpritter76/nethealthz:latest /kube-proxy-healthcheck.sh <hostname>

OR

docker run mpritter76/nethealthz:latest /flannel-healthcheck.sh <hostname>
```
