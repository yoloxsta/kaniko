# kaniko
```
kubectl exec -it curl-pod -n account -- sh
tar xf xyz.tgz

kubectl create secret docker-registry regcred --docker-username=xyz --docker-password=token -n namespace

https://readmedium.com/en/https:/aws.plainenglish.io/166-mastering-kubernetes-how-to-build-and-deploy-a-scalable-voting-app-a4660698caee 

kubectl rollout history deployment sta-deployment -n jenkins

kubectl rollout undo deployment sta-deployment --to-revision=no: -n jenkins

cp /home/name/xyz/02backend/xyz/aia-as.yml /home/name/xyz/wxyz/jenkins/sta/aia-as.yml.bak


```

Nginx zero to hero ==> https://medium.com/@ksaquib/nginx-zero-to-hero-your-ultimate-guide-from-beginner-to-advanced-mastery-57e2dad6a77a

postgresql ==> https://phoenixnap.com/kb/postgresql-kubernetes

#
##configmaps

```
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
spec:
  containers:
  - env:
    - name: APP_COLOR
      value: blue
    image: kodekloud/webapp-color
    name: webapp-color
#################

kind: ConfigMap
metadata:
  name: webapp-config-map
data:
  APP_COLOR: darkblue
  APP_OTHER: disregard

#####################
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
spec:
  containers:
  - env:
    - name: APP_COLOR
      valueFrom:
       configMapKeyRef:
         name: webapp-config-map
         key: APP_COLOR
    image: kodekloud/webapp-color
    name: webapp-color

##########################

apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-color
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp-color
  template:
    metadata:
      labels:
        app: webapp-color
    spec:
      containers:
      - name: webapp-color
        image: kodekloud/webapp-color
        env:
        - name: APP_COLOR
          value: blue

kubectl set env deployment/webapp-color APP_COLOR=green
kubectl rollout restart deployment webapp-color



```