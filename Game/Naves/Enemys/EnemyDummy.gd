extends Node2D



func _on_Area2D_body_entered(body: Node) -> void:
	print("algo colisiono...")
	if body.is_in_group("Players"):
		print("colisiono: ", body.name)
		body.destruir()
