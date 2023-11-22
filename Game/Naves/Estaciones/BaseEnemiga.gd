#BaseEnemiga.gd
class_name BaseEnemiga
extends Node2D

# Atributos export
export var hitspoints:float = 30.0

# Atributos onready
onready var impacto_sfx:AudioStreamPlayer2D =  $ImpactosSFX

# Atributos
var esta_destruida:bool = false


# Metodos
func _ready() -> void:
	$AnimationPlayer.play(elegir_animacion_aleatoria())
	
# Metodos Custom
func elegir_animacion_aleatoria() -> String:
	randomize()
	var num_anim:int = $AnimationPlayer.get_animation_list().size() - 1
	var indice_anim_aleatoria:int = randi() % num_anim + 1
	var lista_animacion:Array = $AnimationPlayer.get_animation_list()
	return lista_animacion[indice_anim_aleatoria]

func recibir_danio(danio:float)->void:
	hitspoints -= danio
	if hitspoints <= 0.0:
		esta_destruida = true
		queue_free()
	impacto_sfx.play()
	
	

func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

	
