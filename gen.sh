for i in {1..1000}; do dd if=/dev/urandom of=./src/$(printf %05d $i).dat bs=1024 count=1024; done
