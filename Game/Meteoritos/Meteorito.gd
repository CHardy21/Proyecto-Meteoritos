# Meteorito.gd
class_name Meteorito
extends RigidBody2D

## Atributos Export
export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitspoint_base: float = 10.0

## Atributos
var hitspoints:float

## Metodos
func _ready() -> void:
	angular_velocity = vel_ang_base

## Constructor
func crear(pos:Vector2, dir:Vector2,tamanio:float) -> void:
	position = pos
	# Calcular masa, tamaño del sprite y coliionador
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	# radio = diametro /2
	var radio:int = int( $Sprite.texture.get_size().x /2.3 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	# Calcular velocidades
	linear_velocity = vel_lineal_base * dir / tamanio
	angular_velocity = vel_ang_base / tamanio
	# Calcular hitspoints
	hitspoints = hitspoint_base * tamanio
	
	# solo debug
	print("hitspoint: ", hitspoints)
	
	
