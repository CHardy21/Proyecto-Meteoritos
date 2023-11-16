# NaveBase.gd
class_name NaveBase
extends RigidBody2D

## Enums
enum ESTADO{ SPAWN, VIVO, INVENCIBLE, MUERTO }

## Atributos export
export var hitspoint:float = 20.0

## Atributos
var estado_actual: int = ESTADO.SPAWN

## Atributos onready
onready var canion:Canion = $Canion
onready var impacto_sfx:AudioStreamPlayer = $ImpactosSFX
onready var colisionador:CollisionShape2D = $CollisionShape2D


func controlador_estados(nuevo_estado:int) -> void:
	match nuevo_estado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled",true)
			canion.set_puede_disparar(false)
		ESTADO.VIVO:
			colisionador.set_deferred("disabled",false)
			canion.set_puede_disparar(true)
		ESTADO.INVENCIBLE:
			colisionador.set_deferred("disabled",true)
		ESTADO.MUERTO:
			colisionador.set_deferred("disabled",true)
			canion.set_puede_disparar(false)
			Eventos.emit_signal("nave_destruida", self, global_position, 3)
			queue_free()
		_:
			printerr("ERROR de Estado...")
	estado_actual = nuevo_estado

func destruir() -> void:
	controlador_estados(ESTADO.MUERTO)

func recibir_danio(danio:float) -> void:
	hitspoint -= danio
	# print("vida restante player: ", hitspoint)
	if hitspoint <= 0.0:
		destruir()
		
	impacto_sfx.play()

## Señales internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		controlador_estados(ESTADO.VIVO)

func _on_Player_body_entered(body: Node) -> void:
	if body is Meteorito:
		body.destruir()
		destruir()
