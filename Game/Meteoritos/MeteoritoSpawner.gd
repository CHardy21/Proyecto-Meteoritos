# MeteoritoSpawner
class_name MeteoritoSpawner
extends Position2D

export var direccion:Vector2 = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Esto es temporal. como este script se llama antes del script del nivel
	# es necesario esperar a que este listo dicho script para ejecutat el envio
	# de la señal. Sin este "yield" se emite una señal que no recibe nadie
	# ya que Nivel.gd no se ha cargado aun.
	yield(owner, "ready")
	spawnear_meteorito()

func spawnear_meteorito() -> void:
	Eventos.emit_signal("spawn_meteorito", global_position, direccion)
	

