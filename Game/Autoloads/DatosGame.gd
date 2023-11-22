extends Node

# Atributos
var player_actual:Players = null setget set_player_actual, get_player_actual


# Setters y Getters
func set_player_actual(player:Players)-> void:
	player_actual = player

func get_player_actual() -> Players:
	return player_actual


