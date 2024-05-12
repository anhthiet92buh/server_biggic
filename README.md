# server_biggic
Late!
------------------------------------
Ghi chu:
    - Ctrl + K + 0: thu hep cac function
    - Ctrl + K + L: mo rong cac function

Cac buoc tao cluster:
B1: tạo hệ điều hành Ubuntu sever vs ssh (ghi chu: Su dung Terminator de dieu khien may chu cluster)
    - 3 master
    - 3 worker
    - 2 LoadBalancer: cai haproxy va keepalived
    - 1 Virtual IP address

B2: Tao Cluster:

    Kiem tra networking:
    - Cai dat tool: sudo apt install net-tools
    - kiem tra: ifconfig -a
    - Kiem tra uuid: sudo cat /sys/class/dmi/id/product_uuid
    - Tat swap: swapoff -a

    Cai dat Containerd: https://github.com/containerd/containerd/blob/main/docs/getting-started.md
    - Download file: wget https://github.com/containerd/containerd/releases/download/v1.6.24/containerd-1.6.24-linux-amd64.tar.gz
    - Giai nen vao local: tar Cxzvf /usr/local containerd-1.6.24-linux-amd64.tar.gz
    - Tao file service: /usr/local/lib/systemd/system/containerd.service voi noi dung theo nhu Containerd cung cap theo link
    https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

    - Khoi dong Containerd:
        systemctl daemon-reload
        systemctl enable --now containerd
        sudo mkdir -p /etc/containerd
        sudo containerd config default | sudo tee /etc/containerd/config.toml

        Fix cgroup driver: https://kubernetes.io/docs/setup/production-environment/container-runtimes/#systemd-cgroup-driver
        sudo systemctl restart containerd

        Forwarding IPv4 and letting iptables see bridged traffic

    
    - Cai dat runc:
        Tai flie: wget https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.amd64
        install -m 755 runc.amd64 /usr/local/sbin/runc

    - Cai dat CNI plugins
        Tai file: wget https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-amd64-v1.3.0.tgz
        cai dat:
            - mkdir -p /opt/cni/bin
            - tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.3.0.tgz
    - Installing kubeadm, kubelet and kubectl
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl

        curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

        echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

        sudo apt-get update
        sudo apt-get install -y kubelet kubeadm kubectl
        sudo apt-mark hold kubelet kubeadm kubectl
        start kubeadm init
            kubeadm config images pull
            kubeadm init

            mkdir -p $HOME/.kube
            sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
            sudo chown $(id -u):$(id -g) $HOME/.kube/config
            export KUBECONFIG=/etc/kubernetes/admin.conf

            Installing Addons: kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
            ==> kubeadm join .... => finish

            Note: 
                - kubeadm init --apiserver-advertise-address 172.16.68.130 --pod-network-cidr=10.244.0.0/16
                - kubeadm init --control-plane-endpoint="192.168.0.100:6443" --upload-certs --apiserver-advertise-address=192.168.0.101 --pod-network-cidr=10.244.0.0/16
                - check status cni flannel: kubectl get pods --all-namespaces
                - tham khao them: https://github.com/hocchudong/ghichep-kubernetes/blob/master/docs/kubernetes-5min/02.Caidat-Kubernetes.md
                - Sau khi xoa cluster: kubeadm reset -> xoa cni: rm -rf /etc/cni/net.d/10-flannel.conflist

Buoc 3: Set up a High Availability etcd Cluster with kubeadm

    - https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/setup-ha-etcd-with-kubeadm/
    - Put to Environment

        export HOST0=192.168.0.23
        export HOST1=192.168.0.25
        export HOST2=192.168.0.26

        export NAME0="etcd1"
        export NAME1="etcd2"
        export NAME2="etcd3"

    - Install etcd:
        fllowing link: https://etcd.io/docs/v3.5/install/

    - Create load balancer for kube-apiserver
        Cai dat keepalived
            sudo apt install -y keepalived
            Config keepalievd: /etc/keepalived/keepalived.conf
            Following the link: https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#kube-vip
            Setting Environment: (Khoi dong ko mat bien moi truong thi luu trong file /etc/environment va dung lenh source /etc/environment de reload Environment)
                export STATE="MASTER" cho mot may chu master, export STATE="BACKUP" cho cac may con lai
                export INTERFACE="name", name la ten he thong mang, kiem tra bang lenh ip addr
                export ROUTER_ID="51", nen de giong nhau
                export PRIORITY=101" cho may master, export PRIORITY=100" cho may node
                export AUTH_PASS="55" Nen de giong nhau giua cac may, tuy chon pass
                export APISERVER_VIP="192.168.1.165"
                export APISERVER_DEST_PORT="1152" 
        Cai dat HAproxy
            sudo apt install haproxy
            config /etc/haproxy, following link https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#kube-vip
            Setting Environment:
                export APISERVER_DEST_PORT="1152"
                export APISERVER_SRC_PORT="1153"
                export HOST1_ID="Cluster1"
                export HOST1_ADDRESS="192.168.1.165"
    - Run the services on the operating system #https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#options-for-software-load-balancing
        systemctl enable haproxy --now
        systemctl enable keepalived --now
    - Kubeadm init:
        kubeadm init --control-plane-endpoint vip.mycluster.local:8443 [additional arguments ...]
New Test
After finish all off the VM for Kmaster, Kworker, Loadbalancer

- Change MASTER -> BACKUP in Loabalancer VM
- Changer SystemCgoup=true -> systemctl restart containerd
- kubeadm init --control-plane-endpoint="192.168.0.101:6443" --upload-certs --apiserver-advertise-address=192.168.0.100 --pod-network-cidr=10.244.0.0/16

    - kubeadm join 192.168.0.70:6443 --token h4vlgy.2jg5siiwrlu6jn5r --discovery-token-ca-cert-hash sha256:35caa07a4a349ab92c642d06306ef3f0bfcb8bee4b082ee2ad16acf1087a392a --control-plane --certificate-key 924c6951b32bb84554cfff76d917255b8ffe9c4c88e5e9e878501f24e177c554 --apiserver-advertise-address=192.168.0.72
    - -> Join Kworker VM

Fix coredns Pending
    kubectl describe pod coredns-787d4945fb-9k5cl -n kube-system
    kubectl delete pods --all
    kubeadm config images pull

cat << EOF | tee /etc/cni/net.d/10-containerd-net.conflist
{
 "cniVersion": "1.0.0",
 "name": "containerd-net",
 "plugins": [
   {
     "type": "bridge",
     "bridge": "cni0",
     "isGateway": true,
     "ipMasq": true,
     "promiscMode": true,
     "ipam": {
       "type": "host-local",
       "ranges": [
         [{
           "subnet": "10.244.0.0/16"
         }],
         [{
           "subnet": "2001:db8:4860::/64"
         }]
       ],
       "routes": [
         { "dst": "0.0.0.0/0" },
         { "dst": "::/0" }
       ]
     }
   },
   {
     "type": "portmap",
     "capabilities": {"portMappings": true},
     "externalSetMarkChain": "KUBE-MARK-MASQ"
   }
 ]
}
EOF