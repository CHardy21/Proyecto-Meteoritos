class_name Nivel
extends Node2D

onready var contenedor_proyectiles:Node

func _ready() -> void:
	conectar_signals()
	crear_contenedores()

## Metedos Customs
func conectar_signals() -> void:
	Eventos.connect("disparo", self, "_on_disparo")

func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)

func _on_disparo(proyectil:Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)
