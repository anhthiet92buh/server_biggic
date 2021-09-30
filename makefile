protos: protos/service.proto
	protoc protos/service.proto --go_out=plugins=grpc:.
	protoc --dart_out=grpc:protos/ -Iprotos protos/service.proto
	
update:
	dart pub global activate protoc_plugin
	export PATH=${PATH}:/usr/local/go/bin
	export PATH="${PATH}:${HOME}/.local/bin"
	export PATH="${PATH}:${HOME}/.pub-cache/bin"

gomod:
	go mod init github.com/anhthiet92buh/server_biggic
	go mod tidy
rm_gomod:
	rm -rf go.mod go.sum
.PHONY: protos
clean:
	rm -rf protos/*.go protos/*.dart