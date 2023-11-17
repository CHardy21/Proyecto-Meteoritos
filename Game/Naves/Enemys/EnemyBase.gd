#EnemyBase.gd
class_name EnemyBase
extends NaveBase

func _ready() -> void:
	canion.set_esta_disparando(true)

func _on_body_entered(body: Node) -> void:
	._on_body_entered(body)
	if body is Players:
		body.destruir()
		destruir()

