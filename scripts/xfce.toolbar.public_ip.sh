#!/bin/bash

public_ip=$(curl -s http://ifconfig.me/)
json=$(curl -s https://ipapi.co/$public_ip/json/)
country=$(echo $json |jq .country_name -r)

echo "<txt><span weight='bold' face='Hack Nerd Font' fgcolor='#c28b13'> $country</span></txt><icon>netsurf</icon>"
