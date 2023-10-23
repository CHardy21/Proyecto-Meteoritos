class_name Players
extends RigidBody2D

## Enums
enum ESTADO{ SPAWN, VIVO, INVENCIBLE, MUERTO }

## Atributos export
export var potencia_motor = 20
export var potencia_rotacion = 20
export var estela_max: int = 150


## Atributos
var empuje: Vector2 = Vector2.ZERO
var dir_rotacion: int = 0
var estado_actual: int = ESTADO.SPAWN


## Atributos onready
onready var canion:Canion = $Canion
onready var laser: RayoLaser = $LaserBeam2D
onready var estela:Estela = $PositionEstela/Trail2D
onready var motor_sfx:Motor = $MotorSFX

onready var colisionador:CollisionShape2D = $CollisionShape2D


## Metodos
func _unhandled_input(event: InputEvent) -> void:
	## Chequea los estados
	if not esta_input_activo():
		return

	#Control disparo rayo
	if event.is_action_pressed("key_laser_shoot"):
		laser.set_is_casting(true)
	if event.is_action_released("key_laser_shoot"):
		laser.set_is_casting(false)
	
	# Control Estela y SFX del Motor
	if event.is_action_pressed("key_arriba"):
		estela.set_max_points(estela_max)
		motor_sfx.sonido_on()
		
	elif event.is_action_pressed("key_abajo"):
		estela.set_max_points(0)
		motor_sfx.sonido_on()
	
	if(event.is_action_released("key_arriba") or event.is_action_released("key_abajo")):
		motor_sfx.sonido_off()

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)

func _ready() -> void:
	laser.set_is_casting(false)
	controlador_estados(estado_actual)
	## TODO: quitar, solo DEBUG
	## controlador_estados(ESTADO.VIVO)
	
func _process(delta: float) -> void:
	player_input()

## Señales internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		controlador_estados(ESTADO.VIVO)

## Metodos Customs
func player_input() -> void:
		## Chequea los estados
	if not esta_input_activo():
		return
	
	if Input.is_action_pressed("key_arriba"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("key_abajo"):
		empuje = Vector2(-potencia_motor, 0)
		
	if Input.is_action_pressed("key_derecha"):
		dir_rotacion += 1
	elif Input.is_action_pressed("key_izquierda"):
		dir_rotacion -= 1
	
	if Input.is_action_pressed("key_shoot"):
		canion.set_esta_disparando(true)
	if Input.is_action_just_released("key_shoot"):
		canion.set_esta_disparando(false)

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
			canion.set_puede_disparar(true)
			Eventos.emit_signal("nave_destruida", global_position)
			queue_free()
		_:
			printerr("ERROR de Estado...")
	estado_actual = nuevo_estado
	
func esta_input_activo() ->bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	return true

func destruir() -> void:
	controlador_estados(ESTADO.MUERTO)


