NAME                                         STATUS    VOLUME          CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data-my-release-postgresql-0                 Pending                                                            126m
data-my-release-postgresql-ha-postgresql-0   Pending                                                            169m
data-my-release-postgresql-ha-postgresql-1   Pending                                                            169m
postgresql-pv-claim                          Bound     postgresql-pv   10Gi       RWO            manual         11s
root@master:/home/thiet/Desktop/server_biggic/kubernetes/helmpostgres# helm install psql-test bitnami/postgresql --set persistence.existingClaim=postgresql-pv-claim --set volumePermissions.enabled=true
NAME: psql-test
LAST DEPLOYED: Sun Jan  2 22:33:09 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql
CHART VERSION: 10.14.2
APP VERSION: 11.14.0

** Please be patient while the chart is being deployed **

PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    psql-test-postgresql.default.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default psql-test-postgresql -o jsonpath="{.data.postgresql-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run psql-test-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:11.14.0-debian-10-r18 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host psql-test-postgresql -U postgres -d postgres -p 5432



To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/psql-test-postgresql 5432:5432 && PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432