package main

import (
	"context"
	"log"
	"net"
	"os"
	"sync"
	"google.golang.org/grpc"
	glog "google.golang.org/grpc/grpclog"
	"protos/service.pb.go"
)

var grpcLog glog.LoggerV2

func init(){
	grpcLog = glog.NewLoggerV2(os.Stdout, os.Stdout, os.Stdout)
}


type Connection struct {
	stream protos.Broadcast_CreateStreamServer
	id	string
	active bool
	error chan error
}

type Server struct {
	Connection []*Connection
}

func (s *Server) CreateStream(pconn *protos.Connect, stream  protos.Broadcast_CreateStreamServer) error{
	conn := &Connection{
		stream: stream,
		id: pconn.User.Id,
		active: true,
		error: make(chan error),
	}

	s.Connection = append(s.Connection, conn)

	return <-conn.error
}

func (s *Server) BroadcastMessage(ctx context.Context, msg *protos.Message) (*protos.Close, error){
	wait := sync.WaitGroup{}
	done := make(chan int)

	for _,conn := range s.Connection {
		wait.Add(1)

		go func(msg *protos.Message, conn *Connection) {
			defer wait.Done()

			if conn.active {
				err := conn.stream.Send(msg)
				grpcLog.Info("Sending message to: ", conn.stream)

				if err != nil {
					grpcLog.Errorf("Error with Stream: %v - Error: %v ", conn.stream, err)
					conn.active = false
					conn.error <- err
				}
				
			}
		}(msg, conn)
	}

	go func() {
		wait.Wait()
		close(done)
	}()

	<- done
	return &protos.Close{},nil
}

func main()  {
	var connections []*Connection
	server := &Server{connections}

	grpcServer := grpc.NewServer()
	listener, err := net.Listen("tcp","127.0.0.1:8080")
	if err != nil {
		log.Fatalf("Error creating the Server %v",err)
	}

	grpcLog.Info("Starting Server at port: 8080")

	protos.RegisterBroadcastServer(grpcServer, server)
	grpcServer.Serve(listener)
	
}