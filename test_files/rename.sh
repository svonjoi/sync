#!/usr/bin/env bash
file="$(find src | shuf | head -1)"
echo renaming $file
mv "$file" "$file.renamed"
