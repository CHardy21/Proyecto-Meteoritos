# EstacionRecarga.gd
class_name EstacionRecarga
extends Node2D

# Variables export
export var energia:float = 6.0
export var radio_energia_entregada:float =  0.05

# Atributos
var nave_player: Players = null

# Metodos
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("key_recarga_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	if event.is_action("key_recarga_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)

# Señales Internas
func _on_AreaColision_body_entered(body:Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body:Node) -> void:
	body.set_gravity_scale(0.1)

func _on_AreaRecarga_body_exited(body):
	body.set_gravity_scale(0.0)
