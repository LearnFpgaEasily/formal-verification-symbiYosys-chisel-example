netlist: src/chisel/main.scala
	docker run --user $(id -u):$(id -g)                                                 \
			   -v $(PWD)/src/chisel/build.sbt:/project/build.sbt                        \
	           -v $(PWD)/src/chisel/main.scala:/project/src/main/scala/main.scala       \
			   -v $(PWD)/build/artifacts/netlist:/project/build/artifacts/netlist       \
			   -v $(PWD)/build/logs/:/project/build/logs                                \
			   -w="/project/"                                                           \
			   chisel /bin/bash -c "sbt run > ./build/logs/netlist_log.txt 2>&1"

test_formal: build/artifacts/netlist/Counter.v src/formal/concat.sh src/formal/formal_counter.sv
	docker run --user $(id -u):$(id -g)                                                 \
			-v $(PWD):/project/ -w="/project/" osscad /bin/bash -c "./src/formal/formal_test.sh"

all: clean build_tree netlist test_formal

clean:
	rm -rf build/

build_tree:
	mkdir build
	mkdir build/artifacts
	mkdir build/artifacts/netlist/
	mkdir build/artifacts/formal
	mkdir build/logs/
