#Player.gd
class_name Players
extends NaveBase

## Atributos export
export var potencia_motor = 18
export var potencia_rotacion = 260
export var estela_max: int = 150

## Atributos
var empuje: Vector2 = Vector2.ZERO
var dir_rotacion: int = 0

## Atributos onready
onready var laser: RayoLaser = $LaserBeam2D setget , get_laser
onready var estela:Estela = $PositionEstela/Trail2D
onready var motor_sfx:Motor = $MotorSFX
onready var escudo:Escudo = $Escudo setget , get_escudo

## Setters y Getters
func get_laser() -> RayoLaser:
	return laser

func get_escudo() -> Escudo:
	return escudo

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
	
	#Control Escudo
	if event.is_action_pressed("key_shield") and not escudo.get_esta_activado():
		escudo.activar()

func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)

func _ready() -> void:
	DatosGame.set_player_actual(self)
	laser.set_is_casting(false)
	controlador_estados(estado_actual)
	## TODO: quitar, solo DEBUG
	## controlador_estados(ESTADO.VIVO)
	
func _process(_delta: float) -> void:
	player_input()

## Metodos Customs
func esta_input_activo() ->bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	return true

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

	# al soltar las teclas, detengo el avance,retroceso y/o rotacion de la nave
	if Input.is_action_just_released("key_arriba") or Input.is_action_just_released("key_abajo"):
		empuje = Vector2(0,0)
	if Input.is_action_just_released("key_izquierda") or Input.is_action_just_released("key_derecha"):
		dir_rotacion = 0
	
	if Input.is_action_pressed("key_shoot"):
		canion.set_esta_disparando(true)
	if Input.is_action_just_released("key_shoot"):
		canion.set_esta_disparando(false)

func desactivar_controles()-> void:
	controlador_estados(ESTADO.SPAWN)
	empuje = Vector2.ZERO
	motor_sfx.sonido_off()
	laser.set_is_casting(false)
	
