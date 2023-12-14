# EstacionRecarga.gd
class_name EstacionRecarga
extends Node2D

# Variables export
export var energia:float = 6.0
export var radio_energia_entregada:float =  0.05

# Atributos
var nave_player: Players = null
var player_en_zona:bool = false

onready var cargando_sfx: AudioStreamPlayer = $CargaSFX
onready var estacion_vacia_sfx: AudioStreamPlayer = $VacioSFX
# Metodos
func _unhandled_input(event: InputEvent) -> void:
	if not puede_recargar(event):
		return
	
	#energia -= radio_energia_entregada
	controlar_energia()
	# solopara debug
	print("Energia Estacion: ", energia)
	
	if event.is_action("key_recarga_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	if event.is_action_released("key_recarga_escudo"):
		Eventos.emit_signal("ocultar_energia_escudo")

	if event.is_action("key_recarga_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)
	if event.is_action_released("key_recarga_laser"):
		Eventos.emit_signal("ocultar_energia_laser")

# Metodos Custom
func puede_recargar(event:InputEvent) -> bool:
	var hay_input = event.is_action("key_recarga_escudo") or event.is_action("key_recarga_laser")
	if hay_input and player_en_zona and energia > 0.0:
		if !cargando_sfx.playing:
			cargando_sfx.play()
		return true
	if hay_input and player_en_zona and energia <= 0.0:
		estacion_vacia_sfx.play()
		
	cargando_sfx.stop()
	return false

func controlar_energia() -> void:
	energia -= radio_energia_entregada
	if energia <= 0:
		estacion_vacia_sfx.play()
		
	


# Señales Internas
func _on_AreaColision_body_entered(body:Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body:Node) -> void:
	if body is Players:
		nave_player = body
		player_en_zona = true
		Eventos.emit_signal("detecto_zona_recarga", true)

func _on_AreaRecarga_body_exited(body):
	if body is Players:
		player_en_zona = false
		Eventos.emit_signal("detecto_zona_recarga", false)
		
	if estacion_vacia_sfx.playing:
		estacion_vacia_sfx.stop()
