class_name Escudo
extends Area2D

## Atributos Export
export var energia: float = 8.0
export var radio_desgaste: float = -1.6

## Atributos/Variables
var esta_activado:bool = false setget ,get_esta_activado
var energia_original:float

## Metodos
func _ready() -> void:
	energia_original = energia
	set_process(false)  ## Se impide que se procese la funct _process() al iniciar
	controlar_colisionador(true)

func _process(delta: float) -> void:
	controlar_energia(radio_desgaste * delta)

## Metodos Custom
func controlar_colisionador(esta_desctivado:bool)-> void:
	$CollisionShape2D.set_deferred("disabled", esta_desctivado)

func controlar_energia(consumo:float) -> void:
	energia += consumo
	# Solo DEBUG, quitar luego
	#print("Energia Escudo: ", energia)
	
	# Limitamos la recarga de energia hasta la energia original
	if energia >= energia_original:
		energia = energia_original
	elif energia <= 0.0:
		desactivar()
	
	
func activar() -> void:
	if energia <= 0.0:
		return
	
	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("activando")

func desactivar() -> void:
	set_process(false)
	esta_activado = false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("activando")
	

## Señales Internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activando" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true) ## Activamos la func _process()
		print("Se activo escudo")
		
	if anim_name == "activando" and not esta_activado:
		$AnimationPlayer.stop()
		print("Se Desactivo escudo")

func _on_body_entered(body: Node) -> void:
	body.queue_free()

## Setters y Getters
func get_esta_activado()-> bool:
	return esta_activado



