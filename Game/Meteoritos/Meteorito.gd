# Meteorito.gd
class_name Meteorito
extends RigidBody2D

## Atributos Export
export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitspoint_base: float = 10.0

## Atributos
var hitspoints:float
var esta_en_sector: bool = true setget set_esta_en_sector
var pos_spawn_original:Vector2
var vel_spawn_original:Vector2

## Atributos onready
onready var impacto_sfx:AudioStreamPlayer2D = $ImpactoSFX
onready var anim_impacto:AnimationPlayer = $AnimationPlayer


## Constructor
func crear(pos:Vector2, dir:Vector2,tamanio:float) -> void:
	position = pos
	pos_spawn_original = pos
	
	# Calcular masa, tamaño del sprite y coliionador
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	# radio = diametro /2
	var radio:int = int( $Sprite.texture.get_size().x /2.3 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	# Calcular velocidades
	linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	angular_velocity = (vel_ang_base / tamanio) * aleatorizar_velocidad()
	vel_spawn_original = linear_velocity
	
	# Calcular hitspoints
	hitspoints = hitspoint_base * tamanio
	
	# solo debug
	print("hitspoint: ", hitspoints)

## Setters y Getters
func set_esta_en_sector(valor:bool) -> void:
	esta_en_sector = valor
	
## Metodos
func _ready() -> void:
	angular_velocity = vel_ang_base

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if esta_en_sector:
		return
	var mi_transform := state.get_transform()
	mi_transform.origin = pos_spawn_original
	linear_velocity = vel_spawn_original
	state.set_transform(mi_transform)
	esta_en_sector = true

## Metodos Custom
func recibir_danio(danio:float) -> void:
	hitspoints -= danio
	print("vida restante: ", hitspoints)
	if hitspoints <= 0.0:
		destruir()
	impacto_sfx.play()
	anim_impacto.play("impacto")

func destruir() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	Eventos.emit_signal("meteorito_destruido", global_position)
	queue_free()

func aleatorizar_velocidad() -> float:
	randomize()
	return rand_range(1.1, 1.4)
