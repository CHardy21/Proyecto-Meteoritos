#EnemyOrbital.gd
class_name EnemyOrbital
extends EnemyBase

# Atributos export
export var rango_max_ataque:float = 1400.0

# Atributos
var base_duenia:Node2D

# Constructor
func crear(pos:Vector2, duenia:Node2D):
	global_position = pos
	base_duenia = duenia

# Metodos
func _ready() -> void:
	$AnimationPlayer.play("spawn")
	Eventos.connect("base_destruida", self, "_on_base_destruida")
	#Temporal
	#canion.set_esta_disparando(true)

func rotar_hacia_player()->void:
	.rotar_hacia_player()
	if dir_player.length() > rango_max_ataque:
		canion.set_esta_disparando(false)
	else:
		canion.set_esta_disparando(true)

# Señales Externas
func _on_base_destruida(base:Node2D, _pos) -> void:
	if base == base_duenia:
		destruir()

