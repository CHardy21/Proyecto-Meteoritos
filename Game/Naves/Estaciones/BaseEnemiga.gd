#BaseEnemiga.gd
class_name BaseEnemiga
extends Node2D

# Atributos export
export var hitspoints:float = 30.0
export var orbital:PackedScene = null
export (Array, PackedScene) var rutas
export var num_orbitales:int = 12
export var intervalo_spawn:float = 0.8


# Atributos onready
onready var impacto_sfx:AudioStreamPlayer2D =  $ImpactosSFX
onready var timer_spawner: Timer = $TimerSpawnOrbitales

# Atributos
var esta_destruida:bool = false
var ruta_seleccionada:Path2D

# Metodos
func _ready() -> void:
	timer_spawner.wait_time = intervalo_spawn
	$AnimationPlayer.play(elegir_animacion_aleatoria())
	seleccionar_ruta()

### Temporal
#func _process(delta: float) -> void:
#	var player_objetivo:Players = DatosGame.get_player_actual()
#	if not player_objetivo:
#		return
#	var dir_player:Vector2 = player_objetivo.global_position - global_position
#	var angulo_player:float = rad2deg(dir_player.angle())
#	print(angulo_player)
### END Temporal 


# Metodos Custom
func elegir_animacion_aleatoria() -> String:
	randomize()
	var num_anim:int = $AnimationPlayer.get_animation_list().size() - 1
	var indice_anim_aleatoria:int = randi() % num_anim + 1
	var lista_animacion:Array = $AnimationPlayer.get_animation_list()
	return lista_animacion[indice_anim_aleatoria]

func seleccionar_ruta() -> void:
	randomize()
	var indice_ruta:int = randi() % rutas.size() - 1
	ruta_seleccionada = rutas[indice_ruta].instance()
	add_child(ruta_seleccionada)


func recibir_danio(danio:float)->void:
	hitspoints -= danio
	#print("Vida restante: ", hitspoints)
	if hitspoints <= 0.0 and not esta_destruida:
		esta_destruida = true
		destruir()
	impacto_sfx.play()
	
func destruir()->void:
	var posicion_partes = [
		$Sprites/Sprite.global_position,
		$Sprites/Sprite2.global_position,
		$Sprites/Sprite3.global_position,
		$Sprites/Sprite4.global_position
	]
	Eventos.emit_signal("base_destruida", self, posicion_partes)
	Eventos.emit_signal("minimapa_objeto_destruido", self)
	queue_free()

func spawnear_orbital()->void:
	num_orbitales -= 1
	
	var pos_spawn:Vector2 = detectar_cuadrante()
	ruta_seleccionada.global_position = global_position
	
	var new_orbital:EnemyOrbital = orbital.instance()
	new_orbital.crear(
		global_position + pos_spawn,
		self,
		ruta_seleccionada
		)
	Eventos.emit_signal("spawn_orbital", new_orbital)


func detectar_cuadrante() -> Vector2:
	var player_objetivo:Players = DatosGame.get_player_actual()

	if not player_objetivo:
		return Vector2.ZERO

	var dir_player:Vector2 = player_objetivo.global_position - global_position
	var angulo_player:float = rad2deg(dir_player.angle())

	if abs(angulo_player) <= 45.0:
		# Player ingresa por la derecha
# warning-ignore:standalone_expression
		ruta_seleccionada.rotation_degrees == 180.0
		return $PosicionesSpawn/Este.position
	elif abs(angulo_player) > 135.0 and abs(angulo_player) <= 180.0:
		# Player ingresa po la izquierda
# warning-ignore:standalone_expression
		ruta_seleccionada.rotation_degrees == 0.0
		return $PosicionesSpawn/Oeste.position
	elif abs(angulo_player) > 45.0 and abs(angulo_player) <= 135.0:
		# player ingresa o por arriba o por abajo
		if sign(angulo_player) > 0:
			# Player ingresa por abajo
# warning-ignore:standalone_expression
			ruta_seleccionada.rotation_degrees == 270.0
			return $PosicionesSpawn/Sur.position
		else:
			# Player ingresa por arriba
# warning-ignore:standalone_expression
			ruta_seleccionada.rotation_degrees == 90.0
			return $PosicionesSpawn/Norte.position
	# por defecto se spawnea desde el norte
	return $PosicionesSpawn/Norte.position


# Señales Internas
func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_VisibilityNotifier2D_screen_entered() -> void:
	#Spawn Orbital
	$VisibilityNotifier2D.queue_free()
	spawnear_orbital()
	timer_spawner.start()



func _on_TimerSpawnOrbitales_timeout() -> void:
	if num_orbitales == 0:
		timer_spawner.stop()
		return
	spawnear_orbital()

