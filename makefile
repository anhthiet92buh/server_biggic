protos: protos/service.proto
	protoc protos/service.proto --go_out=plugins=grpc:.
	protoc protos/service.proto --dart_out=plugins=grpc:.

update:
	export PATH=$PATH:/usr/local/go/bin

gomod:
	go mod init github.com/anhthiet92buh/server_biggic
	go mod tidy
rm_gomod:
	rm -rf go.mod go.sum
clean:
	rm -rf proto/*.go