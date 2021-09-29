protos: proto/service.proto
	protoc protos/service.proto --go_out=plugins=grpc:.

update:
	export PATH=$PATH:/usr/local/go/bin

clean:
	rm -rf proto/*.go