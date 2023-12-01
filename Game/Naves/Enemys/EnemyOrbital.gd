#EnemyOrbital.gd
class_name EnemyOrbital
extends EnemyBase

## ATRIBUTOS
# Variables Export
export var rango_max_ataque:float = 1400.0
export var velocidad:float = 300.0

# Variables Onready
onready var detector_obstaculo:RayCast2D = $DetectorObstaculo

# Variables
var base_duenia:Node2D
var ruta:Path2D
var path_follow:PathFollow2D

# Constructor
func crear(pos:Vector2, duenia:Node2D, ruta_duenia:Path2D):
	global_position = pos
	base_duenia = duenia
	ruta = ruta_duenia
	path_follow = PathFollow2D.new()
	ruta.add_child(path_follow)

# Metodos
func _ready() -> void:
	$AnimationPlayer.play("spawn")
	Eventos.connect("base_destruida", self, "_on_base_destruida")
	#Temporal
	#canion.set_esta_disparando(true)

func _process(delta: float) -> void:
	path_follow.offset += delta * velocidad
	position = path_follow.global_position


# Métodos Customs
func rotar_hacia_player()->void:
	.rotar_hacia_player()
	if dir_player.length() > rango_max_ataque or detector_obstaculo.is_colliding():
		canion.set_esta_disparando(false)
	else:
		canion.set_esta_disparando(true)

# Señales Externas
func _on_base_destruida(base:Node2D, _pos) -> void:
	if base == base_duenia:
		destruir()

