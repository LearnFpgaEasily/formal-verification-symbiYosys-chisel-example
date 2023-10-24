#!/bin/bash
# inject the formal assertion in the source file
./src/formal/concat.sh src/formal/formal_counter.sv build/artifacts/netlist/Counter.v 
#run formal verification
sby -f src/formal/counter.sby
# so that make clean work
chmod -R 777 src/formal/counter
# move artifacts to build folder
mv src/formal/counter build/artifacts/formal/