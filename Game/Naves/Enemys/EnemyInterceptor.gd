#EnemyInterceptor.gd
class_name EnemyInterceptor
extends EnemyBase

# Enums
enum ESTADO_IA { IDLE, ATACANDOQ, ATACANDOP, PERSECUCION }

# ATRIBUTOS EXPORT
export var potencia_max:float = 800.0

# ATRIBUTOS
var estado_ia_actual:int = ESTADO_IA.IDLE
var potencia_actual:float = 0.0




# Metodos
func _ready() -> void:
	$AnimationPlayer.play("spawn")

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	linear_velocity += dir_player.normalized() * potencia_actual * state.get_step()
	
	linear_velocity.x = clamp(linear_velocity.x, -potencia_max, potencia_max)
	linear_velocity.y = clamp(linear_velocity.y, -potencia_max, potencia_max)
#	if potencia_actual == potencia_max:
#		print("linear_velocity.x: ", linear_velocity.x)
#		print("linear_velocity.y: ", linear_velocity.y)
#		print(potencia_actual)
#		print(potencia_max)

# Metodos Custom
# FSM (Maquina de Estados Finitos)
func controlador_estados_ia(nuevo_estado:int) -> void:
	match nuevo_estado:
		ESTADO_IA.IDLE:
			canion.set_esta_disparando(false)
			potencia_actual = 0.0
		ESTADO_IA.ATACANDOQ:
			canion.set_esta_disparando(true)
			potencia_actual = 0.0
		ESTADO_IA.ATACANDOP:
			canion.set_esta_disparando(true)
			potencia_actual = potencia_max
		ESTADO_IA.PERSECUCION:
			canion.set_esta_disparando(false)
			potencia_actual = potencia_max
		_:
			print("ERROR de Estados.")

	estado_ia_actual = nuevo_estado

# Señales Internas
func _on_AreaDisparo_body_entered(_body:Node):
	controlador_estados_ia(ESTADO_IA.ATACANDOP)
	print(estado_ia_actual)

func _on_AreaDisparo_body_exited(_body:Node):
	controlador_estados_ia(ESTADO_IA.PERSECUCION)
	print(estado_ia_actual)

func _on_AreaDeteccion_body_entered(_body:Node):
	controlador_estados_ia(ESTADO_IA.ATACANDOQ)
	print(estado_ia_actual)

func _on_AreaDeteccion_body_exited(_body:Node):
	controlador_estados_ia(ESTADO_IA.ATACANDOP)
	print(estado_ia_actual)


