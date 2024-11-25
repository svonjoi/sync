#!/usr/bin/env bash

nfiles=$(mktemp)
printf %s\\n ./src/* | tee >(wc -l >$nfiles) | shuf | head -$(($(cat $nfiles) /2)) \
| while read file; do
	dd if=/dev/urandom of=$file bs=1024 count=1024
done
rm $nfiles
