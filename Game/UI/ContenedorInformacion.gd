#ContenedorInformacion.gd
class_name ContenedorInformacion
extends NinePatchRect

## ATRIBUTOS
# Variables onready
onready var texto_contenedor:Label = $Label
onready var auto_ocultar_timer:Timer = $AutoOcultarTimer
onready var animaciones: AnimationPlayer = $AnimationPlayer

# Variables Export
export var auto_ocultar: bool = false setget set_auto_ocultar


# Setters y Getters
func set_auto_ocultar(valor:bool)-> void:
	auto_ocultar = valor
	
# Metodos custom
func mostrar() -> void:
	animaciones.play("mostrar")

func ocultar() -> void:
	animaciones.play("ocultar")

func mostrar_suavizado() -> void:
	animaciones.play("mostrar_suavizado")
	if auto_ocultar:
		auto_ocultar_timer.start()

func ocultar_suavizado() -> void:
	animaciones.play("ocultar_suavizado")

func modificar_texto(texto:String) -> void:
	texto_contenedor.text = texto

func _on_AutoOcultarTimer_timeout() -> void:
	ocultar_suavizado()
	

