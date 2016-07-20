GOPATH=$(CURDIR)/go

.PHONY : all
all : bin/go-websocket-server bin/websocket-bench bin/cpp-websocket-server

bin/go-websocket-server : $(GOPATH)/bin/go-websocket-server
	cp $< $@

bin/websocket-bench : $(GOPATH)/bin/websocket-bench
	cp $< $@

$(GOPATH)/bin/go-websocket-server : $(GOPATH)/src/hashrocket/go-websocket-server/*.go
	cd go/src/hashrocket/go-websocket-server && go install

$(GOPATH)/bin/websocket-bench : $(GOPATH)/src/hashrocket/websocket-bench/*.go
	cd go/src/hashrocket/websocket-bench && go install

bin/cpp-websocket-server : cpp/src/*
	g++ -std=c++14 -I cpp/vendor/jsoncpp/include cpp/src/*.cpp cpp/vendor/jsoncpp/src/jsoncpp.cpp -lboost_system -o bin/cpp-websocket-server

.PHONY : clean
clean :
	rm -f bin/*
	rm -f $(GOPATH)/bin/*