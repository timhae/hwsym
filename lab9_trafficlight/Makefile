SHELL:=/usr/bin/env bash

FORMAT=clang-format
FORMATFLAGS=-i -style="{IndentWidth: 4,TabWidth: 4}"

CXX=clang++
CXXFLAGS=-std=c++11 -Wall -Wunused-command-line-argument -pedantic \
		 -L$(SYSTEMC_PATH)/lib-linux64 \
		 -lsystemc -Wl,-rpath,$(SYSTEMC_PATH)/lib-linux64 \
		 -I$(SYSTEMC_PATH)/include

main: main.o
	$(CXX) $(CXXFLAGS) -o $@ $^
	./main

main.o: $(wildcard *.h) $(wildcard *.cpp)
	$(CXX) $(CXXFLAGS) -c main.cpp

.PHONY: format
format: $(wildcard *.h) $(wildcard *.cpp)
	$(FORMAT) $(FORMATFLAGS) $^

.PHONY: clean
clean:
	rm -f main main.o
