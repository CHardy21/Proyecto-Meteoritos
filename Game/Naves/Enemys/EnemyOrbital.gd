#EnemyOrbital
class_name EnemyOrbital
extends EnemyBase


export var rango_max_ataque:float = 1400.0

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
