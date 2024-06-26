
main: main.go
	go run main.go

protos: protos/mainService.proto
	protoc protos/service.proto --go_out=plugins=grpc:.
	protoc --dart_out=grpc:protos/ -Iprotos protos/service.proto

Dproto: protos/mainService.proto
	rm -rf protos/*.go
	protoc --dart_out=grpc:protos/ -Iprotos protos/service.proto
Gproto: protos/mainService.proto
	rm -rf protos/*.dart
	protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative protos/mainService.proto
	
deno:
	export DENO_INSTALL="/home/$USER/.deno"
	export PATH="$DENO_INSTALL/bin:$PATH"
updatego:
	go get -u all
updatedart:
	dart pub global activate protoc_plugin
exportPath: #Just copy and paste to Terninal, Do not use commandline "make exportPath" in Terninal
	export PATH="$PATH:$(go env GOPATH)/bin"
	export PATH=$PATH:/usr/local/go/bin
	export PATH="$PATH:$HOME/.local/bin"
	export PATH="$PATH:$HOME/.pub-cache/bin"
	export GOROOT=/usr/local/go && export GOPATH=$HOME/go && export GOBIN=$GOPATH/bin && export PATH=$PATH:$GOROOT:$GOPATH:$GOBIN

gomod:
	rm -rf go.mod go.sum
	go mod init github.com/anhthiet92buh/server_biggic
	go mod tidy
rm_gomod:
	rm -rf go.mod go.sum
firstGit:
	git config --global user.email "anhthiet92buh@gmail.com"
	git config --global user.name "Thiet"
goInstall:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
.PHONY: protos
clean:
	rm -rf protos/*.go protos/*.dart

#checking file large size on root disk: du -ahx . | sort -rh | head -20