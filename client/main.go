package main

import (
	"context"
	"proto/service.pb.go"
	"sync"
)


var client protos.BroadcastClient
var wait *sync.WaitGroup

func init()  {
	wait = &sync.WaitGroup{}
}

func connect(user *protos.User) error {
	var streamerror error

	stream, err := client.CreateStream(context.Background(), &protos.Connect{
		User: user,
		Active: true,
	})
}