# CamaraPlayer.gd
class_name CamaraPlayer
extends Camera2D

# Variables Export
export var variacion_zoom:float = 0.1

# Metodos
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_acercar"):
		controlar_zoom(-variacion_zoom)
	if event.is_action_pressed("zoom_alejar"):
		controlar_zoom(variacion_zoom)

func controlar_zoom(mod_zoom:float)->void:
	zoom.x += mod_zoom
	zoom.y += mod_zoom
	
