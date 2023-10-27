class_name Proyectil
extends Area2D

var velocidad:Vector2 = Vector2.ZERO
var danio:float = 1.0

func crear(pos:Vector2, dir:float, vel:float, danio_p:int)-> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel,0).rotated(dir)
	
func _physics_process(delta: float) -> void:
	position += velocidad * delta


## Señales internas
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	daniar(area)

func _on_body_entered(body: Node) -> void:
	daniar(body)


## Metodos Custom
func daniar(otro_cuerpo:CollisionObject2D) -> void:
	print("Impacto a ", otro_cuerpo.name)
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)
	queue_free()


