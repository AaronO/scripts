#!/bin/bash

python -c "import zlib,sys; sys.stdout.write(zlib.decompress(sys.stdin.read()))"
