class_name Players
extends RigidBody2D

## Atributos export
export var potencia_motor = 20
export var potencia_rotacion = 20

## Atributos
var empuje: Vector2 = Vector2.ZERO
var dir_rotacion: int = 0

## Atributos onready
onready var canion:Canion = $Canion
onready var laser: RayoLaser = $LaserBeam2D


## Metodos
func _unhandled_input(event: InputEvent) -> void:
	#disparo rayo
	if event.is_action_pressed("key_laser_shoot"):
		laser.set_is_casting(true)
	if event.is_action_released("key_laser_shoot"):
		laser.set_is_casting(false)

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)
	
func _process(delta: float) -> void:
	player_input()
	
func player_input() -> void:
	
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
