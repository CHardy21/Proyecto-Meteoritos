extends Control

export var menu_principal = ""


func _ready():
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_pausa"):
		visible = not visible
		get_tree().paused = not get_tree().paused


func _on_ButtonContinuar_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_ButtonMenuPrincipal_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().paused = false
	get_tree().change_scene(menu_principal)


func _on_ButtonSalir_pressed() -> void:
		get_tree().quit()
