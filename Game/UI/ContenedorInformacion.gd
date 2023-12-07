#ContenedorInformacion.gd
class_name ContenedorInformacion
extends NinePatchRect

# Metodos custom
func mostrar() -> void:
	$AnimationPlayer.play("mostrar")

func ocultar() -> void:
	$AnimationPlayer.play("ocultar")

func mostrar_suavizado() -> void:
	$AnimationPlayer.play("mostrar_suavizado")

func ocultar_suavizado() -> void:
	$AnimationPlayer.play("ocultar_suavizado")
