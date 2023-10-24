class_name Nivel
extends Node2D

export var explosion:PackedScene = null

onready var contenedor_proyectiles:Node

func _ready() -> void:
	conectar_signals()
	crear_contenedores()

## Metedos Customs
func conectar_signals() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("nave_destruida",self,"_on_nave_destruida")

func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)

func _on_disparo(proyectil:Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)

func _on_nave_destruida(posicion:Vector2, numero_explosiones:int) -> void:
	for i in range(numero_explosiones):
		var new_explosion:Node2D = explosion.instance()
		new_explosion.global_position = posicion
		add_child(new_explosion)
		yield(get_tree().create_timer(0.6),"timeout")
	
