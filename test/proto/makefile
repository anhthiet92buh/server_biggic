proto: check.proto
	rm -rf *.go
	protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative check.proto

proto1:
	# protoc --go_out=. --go-grpc_out=. check.proto
	protoc --go_out=. --go-grpc_out=. check.proto
clean:
	rm -rf *.go

.PHONY: proto