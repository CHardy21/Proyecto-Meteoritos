extends Node2D

var hitspoint:float = 10.0


## Señales internas
func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("Players"):
		body.destruir()


## Metodos 
func _process(delta: float) -> void:
	$Canion.set_esta_disparando(true)


## Metodos Custom
func recibir_danio(danio:float) -> void:
	hitspoint -= danio
	print("vida restante: ", hitspoint)
	if hitspoint <= 0.0:
		queue_free()
	
	
