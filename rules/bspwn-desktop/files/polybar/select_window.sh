#!/bin/bash

# Obtén la lista de ventanas abiertas
windows=$(wmctrl -l | awk '{print $1, $2, $3, $4, $5, $6}')

# Utiliza "rofi" para mostrar una lista y seleccionar una ventana
selected_window=$(echo "$windows" | rofi -dmenu -i -p "Selecciona una ventana:" | awk '{print $1}')

# Cambia el enfoque a la ventana seleccionada
wmctrl -i -a "$selected_window"

