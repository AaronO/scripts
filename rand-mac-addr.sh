#!/bin/bash

# Generate new random mac address
MAC_ADDR=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')

# Log new mac address
echo "Changing mac address to : '${MAC_ADDR}'"

# Change mac address
sudo ifconfig en0 ether "${MAC_ADDR}"
