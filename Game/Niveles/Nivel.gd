# Nivel.gd
class_name Nivel
extends Node2D

export var explosion:PackedScene = null
export var meteorito:PackedScene = null
export var explosion_meteorito:PackedScene = null



onready var contenedor_proyectiles:Node
onready var contenedor_meteoritos:Node


func _ready() -> void:
	conectar_signals()
	crear_contenedores()

## Metedos Customs
func conectar_signals() -> void:
# warning-ignore:return_value_discarded
	Eventos.connect("disparo", self, "_on_disparo")
# warning-ignore:return_value_discarded
	Eventos.connect("nave_destruida",self,"_on_nave_destruida")
# warning-ignore:return_value_discarded
	Eventos.connect("spawn_meteorito", self, "_on_spawn_meteoritos")
	# warning-ignore:return_value_discarded
	Eventos.connect("meteorito_destruido", self, "_on_meteorito_destruido")
	

func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	
	contenedor_meteoritos = Node.new()
	contenedor_meteoritos.name = "ContenedorMeteoritos"
	add_child(contenedor_meteoritos)

## Conectar señales externas
func _on_disparo(proyectil:Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)

func _on_nave_destruida(posicion:Vector2, numero_explosiones:int) -> void:
# warning-ignore:unused_variable
	for i in range(numero_explosiones):
		var new_explosion:Node2D = explosion.instance()
		new_explosion.global_position = posicion
		add_child(new_explosion)
		yield(get_tree().create_timer(0.6),"timeout")
	
func _on_spawn_meteoritos(pos_spawn:Vector2, dir_meteorito:Vector2, tamanio:float) -> void:
	var new_meteorito:Meteorito = meteorito.instance()
	new_meteorito.crear(
		pos_spawn,
		dir_meteorito, 
		tamanio
	)
	contenedor_meteoritos.add_child(new_meteorito)
	
func _on_meteorito_destruido(pos:Vector2) -> void:
	var new_explosion:ExplosionMeteorito = explosion_meteorito.instance()
	new_explosion.global_position = pos
	add_child(new_explosion)
