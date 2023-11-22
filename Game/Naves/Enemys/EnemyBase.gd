#EnemyBase.gd
class_name EnemyBase
extends NaveBase

# Atributos
var player_objetivo:Players = null
var dir_player:Vector2


# Metodos
func _ready() -> void:
	player_objetivo = DatosGame.get_player_actual()
# warning-ignore:return_value_discarded
	Eventos.connect("nave_destruida",self,"_on_nave_destruida")


func _physics_process(_delta: float) -> void:
	rotar_hacia_player()

# Señales internas
func _on_body_entered(body: Node) -> void:
	._on_body_entered(body)
	if body is Players:
		body.destruir()
		destruir()

# Metodos Customs
func _on_nave_destruida(nave:NaveBase,_posicion, _explosiones)->void:
	if nave is Players:
		player_objetivo = null

func rotar_hacia_player()->void:
	if player_objetivo:
		dir_player = player_objetivo.global_position - global_position
		rotation = dir_player.angle()
	
	
