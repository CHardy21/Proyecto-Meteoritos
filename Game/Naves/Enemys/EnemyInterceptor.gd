#EnemyInterceptor.gd
class_name EnemyInterceptor
extends EnemyBase

# Enums
enum ESTADO_IA { IDLE, ATACANDOQ, ATACANDOP, PERSECUCION }

# ATRIBUTOS
var estado_ia_actual:int = ESTADO_IA.IDLE

# Metodos Custom
func controlador_estados_ia(nuevo_estado:int) -> void:
	match nuevo_estado:
		ESTADO_IA.IDLE:
			canion.set_esta_disparando(false)
		ESTADO_IA.ATACANDOQ:
			canion.set_esta_disparando(true)
		ESTADO_IA.ATACANDOP:
			canion.set_esta_disparando(true)
		ESTADO_IA.PERSECUCION:
			canion.set_esta_disparando(false)
		_:
			print("ERROR de Estados.")
	
	estado_ia_actual = nuevo_estado

# Señales Internas
func _on_AreaDisparo_body_entered(body):
	controlador_estados_ia(ESTADO_IA.ATACANDOP)

func _on_AreaDisparo_body_exited(body):
	controlador_estados_ia(ESTADO_IA.PERSECUCION)

func _on_AreaDeteccion_body_entered(body):
	controlador_estados_ia(ESTADO_IA.ATACANDOQ)

func _on_AreaDeteccion_body_exited(body):
	controlador_estados_ia(ESTADO_IA.ATACANDOP)
