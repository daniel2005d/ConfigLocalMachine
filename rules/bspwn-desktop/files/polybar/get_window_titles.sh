#!/bin/bash

# Obtener una lista de todos los títulos de ventanas abiertas
window_titles=$(wmctrl -l | awk '{print $4,$5,$6,$7}' | tr '\n' '*')
# Imprimir la lista de títulos
echo "$window_titles"
