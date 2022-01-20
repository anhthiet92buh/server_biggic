package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	"google.golang.org/grpc"

	pb "github.com/anhthiet92buh/server_biggic/protos"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/examples/data"
)

var (
	tls        = flag.Bool("tls", false, "Connection uses TLS if true, else plain TCP")
	certFile   = flag.String("cert_file", "", "The TLS cert file")
	keyFile    = flag.String("key_file", "", "The TLS key file")
	// jsonDBFile = flag.String("json_db_file", "", "A json file containing a list of features")
	port       = flag.Int("port", 10000, "The server port")
)

type mainServer struct{
	pb.UnimplementedMainServiceServer
}

func (*mainServer) MainKeyWord(ctx context.Context,keyWC *pb.KeyWordC) (*pb.KeyWordS, error) {
	fmt.Print("Da nhan duoc KeyWord tu Client:",keyWC.ClientString)
	resp := &pb.KeyWordS{
		ClientString:         "Server da nhan duoc keyWordC tu client",
	}
	return resp,nil
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", *port))
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	var opts []grpc.ServerOption
	if *tls {
		if *certFile == "" {
			*certFile = data.Path("x509/server_cert.pem")
		}
		if *keyFile == "" {
			*keyFile = data.Path("x509/server_key.pem")
		}
		creds, err := credentials.NewServerTLSFromFile(*certFile, *keyFile)
		if err != nil {
			log.Fatalf("Failed to generate credentials %v", err)
		}
		opts = []grpc.ServerOption{grpc.Creds(creds)}
	}
	grpcServer := grpc.NewServer(opts...)
	pb.RegisterMainServiceServer(grpcServer, &mainServer{})
	grpcServer.Serve(lis)

}
