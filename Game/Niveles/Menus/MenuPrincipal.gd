extends Node

export (String, FILE, "*.tscn") var nivel_inicio = ""


func _ready() -> void:
	MusicaGame.play_musica(MusicaGame.get_lista_musicas().menu_principal)
	#OS.set_window_fullscreen(true)

func _on_Button_pressed() -> void:
	MusicaGame.play_boton()
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_inicio)


func _on_Button_Salir_pressed() -> void:
	get_tree().quit()