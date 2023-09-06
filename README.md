# samba-timemachine-docker

This only requires a `USERNAME` and a `PASSWORD` variable. Timemachine seems to expect the service to be listening on 445 so nodeport on k8s won't work. I've only gotten this to work when using `hostPort` and `hostNetwork: true`. In the example, I have the service in place if wanted. Here is my example manifest:

```
# kubectl create ns timemachine
# kubectl create secret generic -n timemachine timemachine-password --from-literal password=$(openssl rand -base64 32)
# get with:
# kubectl -n timemachine get secrets -o jsonpath={.data.password} timemachine-password  | base64 --decode
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: timemachine
  namespace: timemachine
spec:
  replicas: 1
  selector:
    matchLabels:
      app: timemachine
  template:
    metadata:
      labels:
        app: timemachine
    spec:
      nodeSelector:
        datadisk: "true"
      hostNetwork: true
      containers:
      - name: samba
        image: bentastic27/samba-timemachine-docker:latest
        ports:
        - containerPort: 445
          name: samba
          hostPort: 445
        env:
        - name: TM_MAX_SIZE
          value: 100G
        - name: USERNAME
          value: ben
        - name: PASSWORD
          valueFrom:
            secretKeyRef:
              name: timemachine-password
              key: password
        volumeMounts:
        - mountPath: /timemachine
          name: samba-share
      volumes:
      - name: samba-share
        hostPath:
          path: /data/timemachine
          type: Directory
---
apiVersion: v1
kind: Service
metadata:
  name: timemachine
  namespace: timemachine
spec:
  type: NodePort
  selector:
    app: timemachine
  ports:
  - name: samba
    protocol: TCP
    port: 445
    targetPort: samba
    nodePort: 30445
```
