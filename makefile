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
updatego:
	go get -u all
updatedart:
	dart pub global activate protoc_plugin
exportPath:
	export PATH="$PATH:$(go env GOPATH)/bin"
	export PATH=${PATH}:/usr/local/go/bin
	export PATH="${PATH}:${HOME}/.local/bin"
	export PATH="${PATH}:${HOME}/.pub-cache/bin"
	export GOROOT=/usr/local/go && export GOPATH=$HOME/go && export GOBIN=$GOPATH/bin && export PATH=$PATH:$GOROOT:$GOPATH:$GOBIN

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
go:
	protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative protos/service.proto
otherGo:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go get -u google.golang.org/grpc
	sudo apt-get install golang-goprotobuf-dev