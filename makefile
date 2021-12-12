main:
	go run main.go

protos: protos/service.proto
	protoc protos/service.proto --go_out=plugins=grpc:.
	protoc --dart_out=grpc:protos/ -Iprotos protos/service.proto

Dproto:
	rm -rf protos/*.go
	protoc --dart_out=grpc:protos/ -Iprotos protos/service.proto
Gproto:
	rm -rf protos/*.dart
	protoc protos/service.proto --go_out=plugins=grpc:.
	
deno:
	export DENO_INSTALL="/home/${USER}/.deno"
	export PATH="${DENO_INSTALL}/bin:${PATH}"
update:
	go get -u all
	dart pub global activate protoc_plugin
	export PATH="$PATH:$(go env GOPATH)/bin"
	export PATH=${PATH}:/usr/local/go/bin
	export PATH="${PATH}:${HOME}/.local/bin"
	export PATH="${PATH}:${HOME}/.pub-cache/bin"

gomod:
	go mod init github.com/anhthiet92buh/server_biggic
	go mod tidy
rm_gomod:
	rm -rf go.mod go.sum
firstGit:
	git config --global user.email "anhthiet92buh@gmail.com"
	git config --global user.name "Thiet"
.PHONY: protos
clean:
	rm -rf protos/*.go protos/*.dart