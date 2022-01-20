# Update image
Udocker:

# save docker
# docker save -o backupimage.tar iamge iamge .... 
# docker save $(docker images -q) -o backupimage.tar
postgres:
	docker pull postgres
k8s:
	docker pull k8s.gcr.io/kube-apiserver && docker pull k8s.gcr.io/kube-proxy && docker pull k8s.gcr.io/kube-scheduler && docker pull k8s.gcr.io/kube-controller-manager && docker pull k8s.gcr.io/etcd
calico:
	docker pull calico/apiserver && docker pull calico/node && docker pull calico/pod2daemon-flexvol && docker pull calico/cni && docker pull calico/kube-controllers && docker pull calico/apiserver && docker pull calico/kube-controllers