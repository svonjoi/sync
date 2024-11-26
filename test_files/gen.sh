#!/usr/bin/env bash
n=${1:-1000};mkdir -p src;for i in $(eval echo {1..$n}); do dd if=/dev/urandom of=./src/$(printf %05d $i).dat bs=1024 count=1024; done
