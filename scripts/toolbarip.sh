#!/bin/bash

ip=$(hostname -I | grep -E "[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}" -o)
echo "󰒄  $ip"
    