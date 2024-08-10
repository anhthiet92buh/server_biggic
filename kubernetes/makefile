# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml

# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# kubectl get pods --all-namespaces
# kubeadm init --pod-network-cidr=10.32.0.0/12
# sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=
#  kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.15.157

# kubeadm config print init-defaults
# kubeadm config print join-defaults
# kubeadm token create --print-join-command

# kubectl -n kube-system get cm kubeadm-config -o yaml
# kubectl get no -o wide

# kubectl get po -A

# kubectl describe pod -n kube-system coredns.....

# kubectl -n kube-system describe deployment coredns

# kubectl cluster-info

# kubectl get ns

# kubectl cluster-info
# kubectl cluster-info dump

# kubectl -n kube-system get cm kubeadm-config -o yaml

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml

# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml

# kubectl -n <namespace-name> describe pod <pod name>
# kubectl -n <namespace-name> logs -p  <pod name> 

# tao pod
# kubectl run nginx --image nginx
# kubectl get pod
# docker ps
# kubectl delete pods <pod>

# namespaces
# kubectl get namespaces
# kubectl describe namespaces <name>
# kubectl create -f ./my-namespace.yaml or 
# kubectl create namespace <insert-namespace-name-here>
# delete
# kubectl delete namespaces <insert-some-namespace-name>

# kubectl get deployment namespace ...
# kubectl describe namespace kube-system

# Show ServiceAccount
# kubectl get sa

group:
	kubectl create ns svbigic
	kubectl get ns
# Delete group: kubectl delete ns svbigic

# Create ServiceAccount thietsa
csa:
	kubectl create sa thietsa
	kubectl describe sa thietsa

docker:
	systemctl status docker

Create storage


# make kubernetes dashboard
# install dashboard:  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
# kubectl apply -f createUserAdmin.yaml
# kubectl apply -f createCRB.yaml
# get token: kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
# Token: eyJhbGciOiJSUzI1NiIsImtpZCI6IkZOSmVPRlp5R2ZyMWRFWGhiVWNGYjMxeHpYXzNKQllickF6Ylhyd1prckEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLXg3cGJ6Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI2MmEzOGIxOS0wNjVlLTRmYzQtYjVkOC1hMTM4ZGNjZWM4ZmEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.rmhP-KGdggwY0L1ER14G6u_FQ61CEBMNmTLpzqFPFF0soxMWpdlukr0uChGLgq2eSYP0sJUjr4rThMUp2bOJNXChhVlZa-5CLHaN5Fl9NiTpc11TuWMrBkpRXl0OXNS8ix4S_5xK3zzIVxZXPQEGTsBMwZ73v0mqpAdpWezpnQ8Wmspc1jrAviyHaQaWD0JiOMy8mAlj58RKZy_nqZyrN7oUJbkOJoG9ld6FCkCcszTfDee-9W1JuZvp1eB6iqGqXjcpu9-x5Pbn1Y-jC6PgNwlWGboj9F4u8XW-mDkDxEAeldUeeLgMjEZZ6nDeOBYS268qD5AhN1sUJs1h0v0hOg
# Deloy postgresql using Helm
# kubectl edit service kubernetes-dashboard -n kubernetes-dashboard


install postgresql-HA
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-postgresql-ha bitnami/postgresql-ha
helm delete my-postgresql-ha

NAME: my-postgresql-ha
LAST DEPLOYED: Tue Dec 28 11:29:14 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql-ha
CHART VERSION: 8.1.3
APP VERSION: 11.14.0
** Please be patient while the chart is being deployed **
PostgreSQL can be accessed through Pgpool via port 5432 on the following DNS name from within your cluster:

    my-postgresql-ha-pgpool.default.svc.cluster.local

Pgpool acts as a load balancer for PostgreSQL and forward read/write connections to the primary node while read-only connections are forwarded to standby nodes.

To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-postgresql-ha-postgresql -o jsonpath="{.data.postgresql-password}" | base64 --decode)

To get the password for "repmgr" run:

    export REPMGR_PASSWORD=$(kubectl get secret --namespace default my-postgresql-ha-postgresql -o jsonpath="{.data.repmgr-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run my-postgresql-ha-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql-repmgr:11.14.0-debian-10-r12 --env="PGPASSWORD=$POSTGRES_PASSWORD"  \
        --command -- psql -h my-postgresql-ha-pgpool -p 5432 -U postgres -d postgres

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/my-postgresql-ha-pgpool 5432:5432 psql -h 127.0.0.1 -p 5432 -U postgres -d postgres
///////////////////////////////////////////////////////
helm install postgresql bitnami/postgresql --set persistence.existingClaim=postgresql-pvc --set volumePermissions.enabled=true

NAME: postgresql
LAST DEPLOYED: Wed Dec 29 22:03:42 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql
CHART VERSION: 10.13.15
APP VERSION: 11.14.0

** Please be patient while the chart is being deployed **

PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    postgresql.default.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgresql-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:11.14.0-debian-10-r17 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host postgresql -U postgres -d postgres -p 5432



To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/postgresql 5432:5432 &
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432

# Deloy postgresql in Docker
Download image: docker pull postgres

docker run --name demo-postgres -e POSTGRES_PASSWORD=11520380 -d postgres -p 5432
docker exec -it demo-postgres bash
psql -U postgres

Delete image or volume or build cache doesn't use
docker image prune
docker volume prune
docker builder prune




//////////////////////////////////////
PostgreSQL-Standar
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/postgresql-ha -n ns-postgresql


# Kubernete New 26/06/2024

Fix CGroup in /etc/keepalived/keepalived.conf  in Loadbalancer
Master -> Backup in /etc/containerd/config.toml => systemctl restart containerd

kmaster 1
kubeadm init --control-plane-endpoint="192.168.1.190:6443" --upload-certs --apiserver-advertise-address=192.168.1.191 --pod-network-cidr=10.244.0.0/16
kubeadm config images pull

#Deploy PgAdmin
Step 1: Create file pg-secret.yaml
    apiVersion: v1
    kind: Secret
    type: Opaque
    metadata:
    name: pgadmin
    data: #Put encode base64 here, to show key: echo "Anhthiet92buh@" | base64
kubectl apply -f pg-secret.yaml

Step 2: ConfigMap, Create file pg-config.yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
    name: pgadmin-config
    data:
    servers.json: |
    {
        "Servers": {
            "1": {
            "Name": "PostgreSQL DB",
            "Group": "Servers",
            "Port": 5432,
            "Username": "postgres",
            "Host": "postgres.domain.com",
            "SSLMode": "prefer",
            "MaintenanceDB": "postgres"
            }
        }
    }
kubectl apply -f pg-config.yaml

Step 3: Service, create file pg-service.yaml
    apiVersion: v1
    kind: Service
    metadata:
    name: pgadmin-service
    spec:
    ports:
    - protocol: TCP
    port: 80
    targetPort: http
    selector:
    app: pgadmin
    type: NodePort
kubectl apply -f pg-service.yaml

Step 4: StatefulSet, Create file pg-statefulset.yaml

apiVersion: apps/v1
kind: StatefulSet
metadata:
 name: pgadmin
spec:
 serviceName: pgadmin-service
 podManagementPolicy: Parallel
 replicas: 1
 updateStrategy:
   type: RollingUpdate
 selector:
   matchLabels:
     app: pgadmin
 template:
   metadata:
     labels:
       app: pgadmin
   spec:
     terminationGracePeriodSeconds: 10
     containers:
       - name: pgadmin
         image: dpage/pgadmin4:5.4
         imagePullPolicy: Always
         env:
         - name: PGADMIN_DEFAULT_EMAIL
           value: user@domain.com
         - name: PGADMIN_DEFAULT_PASSWORD
           valueFrom:
             secretKeyRef:
               name: pgadmin
               key: pgadmin-password
         ports:
         - name: http
           containerPort: 80
           protocol: TCP
         volumeMounts:
         - name: pgadmin-config
           mountPath: /pgadmin4/servers.json
           subPath: servers.json
           readOnly: true
         - name: pgadmin-data
           mountPath: /var/lib/pgadmin
     volumes:
     - name: pgadmin-config
       configMap:
         name: pgadmin-config
 volumeClaimTemplates:
 - metadata:
     name: pgadmin-data
   spec:
     accessModes: [ "ReadWriteOnce" ]
     resources:
       requests:
         storage: 3Gi

kubectl apply -f pg-statefulset.yaml
