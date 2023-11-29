#EnemyOrbital.gd
class_name EnemyOrbital
extends EnemyBase

# Atributos export
export var rango_max_ataque:float = 1400.0

# Atributos
var estacion_duenia:Node2D

# Constructor
func crear(pos:Vector2, duenia:Node2D):
	global_position = pos
	estacion_duenia = duenia
	


# Metodos
func _ready() -> void:
	$AnimationPlayer.play("spawn")
	#Temporal
	#canion.set_esta_disparando(true)

func rotar_hacia_player()->void:
	.rotar_hacia_player()
	if dir_player.length() > rango_max_ataque:
		canion.set_esta_disparando(false)
	else:
		canion.set_esta_disparando(true)
