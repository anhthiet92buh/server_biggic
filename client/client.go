package main

import (
	"bufio"
	"context"
	"flag"
	"fmt"
	"log"
	"os"
	"time"

	pb "github.com/anhthiet92buh/server_biggic/protos"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/examples/data"
)


var (
	tls                = flag.Bool("tls", false, "Connection uses TLS if true, else plain TCP")
	caFile             = flag.String("ca_file", "", "The file containing the CA root cert file")
	serverAddr         = flag.String("server_addr", "localhost:10000", "The server address in the format of host:port")
	serverHostOverride = flag.String("server_host_override", "x.test.example.com", "The server name used to verify the hostname returned by the TLS handshake")
)

func main(){
	flag.Parse()
	var opts []grpc.DialOption
	if *tls {
		if *caFile == "" {
			*caFile = data.Path("x509/ca_cert.pem")
		}
		creds, err := credentials.NewClientTLSFromFile(*caFile, *serverHostOverride)
		if err != nil {
			log.Fatalf("Failed to create TLS credentials %v", err)
		}
		opts = append(opts, grpc.WithTransportCredentials(creds))
	} else {
		opts = append(opts, grpc.WithInsecure())
	}

	opts = append(opts, grpc.WithBlock())
	conn, err := grpc.Dial(*serverAddr, opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer conn.Close()
	client := pb.NewMainServiceClient(conn)
	ctx,cancel := context.WithTimeout(context.Background(),time.Second)
	defer cancel()
	
	reader	:= bufio.NewReader(os.Stdin)
	input,_	:= reader.ReadString('\n')
	fmt.Printf("%v",input)
	get,err := client.MainKeyWord(ctx,&pb.KeyWordC{ClientString: input,})

	if err != nil {
		fmt.Printf("Ko ket noi den server.....")
	}
	fmt.Print("Gia tri Server tra ve: ", get.GetClientString(),"\n")
}