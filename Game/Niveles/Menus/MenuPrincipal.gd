extends Node


func _ready() -> void:
	MusicaGame.play_musica(MusicaGame.get_lista_musicas().menu_principal)

func _on_Button_pressed() -> void:
	MusicaGame.play_boton()
	get_tree().change_scene("res://Game/Niveles/NivelTest.tscn")
