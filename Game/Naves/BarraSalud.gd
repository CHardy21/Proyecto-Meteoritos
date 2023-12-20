##BarraSalud.gd
class_name BarraSalud
extends ProgressBar

# Variables Export
export var siempre_visible:bool = false

# Variables onready
onready var tween_visibilidad:Tween = $TweenVisibilidad

# Métodos

func _ready() -> void:
	modulate = Color(1,1,1,siempre_visible)

# Métodos Customs

func set_valores(hitspoint:float) -> void:
	max_value = hitspoint
	value = hitspoint

func set_hitspoint_actual(hitspoint:float) -> void:
	value = hitspoint

func controlar_barra(hitspoints_nave:float, mostrar:bool) -> void:
	value = hitspoints_nave
	
	if not tween_visibilidad.is_active() and modulate.a != int(mostrar):
# warning-ignore:return_value_discarded
		tween_visibilidad.interpolate_property(
			self,
			"modulate",
			Color(1, 1, 1, not mostrar),
			Color(1, 1, 1, mostrar),
			1.0,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
			)
# warning-ignore:return_value_discarded
		tween_visibilidad.start()

# Señales Internas

func _on_TweenVisibilidad_tween_all_completed() -> void:
	if modulate.a == 1.0:
		controlar_barra(value, false)
