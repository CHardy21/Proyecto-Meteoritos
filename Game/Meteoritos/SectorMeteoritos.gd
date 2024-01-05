# SectorMeteoritos.gd
class_name SectorMeteoritos
extends Node2D

#export var cantidad_meteoritos: int = 0
export var intervalo_spawn:float = 1.5

var spawners: Array
var cantidad_meteoritos:int 

# Contructor (Crea el sector Meteoritos)
func crear(pos:Vector2, meteoritos:int) -> void:
	print("Posicion: ", pos)
	print("meteoritos: ", meteoritos)
	global_position = pos
	cantidad_meteoritos = meteoritos
	print("Cant. Meteritos en sector: ", meteoritos)

# Metodos
func _ready() -> void:
	$SpawnTimer.wait_time = intervalo_spawn
	$AnimationPlayer.play("advertencia")
	
	almacenar_spawners()
	conectar_seniales_detectores()

# Metodos Custom
func almacenar_spawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)

func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()

func conectar_seniales_detectores() -> void:
	for detector in $DetectorFueraZona.get_children():
		detector.connect("body_entered", self, "_on_detector_body_entered")


# Señales Internas
func _on_SpawnTimer_timeout() -> void:
	#print("Cant. Spawneada Meteoritos: ", cantidad_meteoritos)
	if cantidad_meteoritos == 0:
		$SpawnTimer.stop()
		return
	spawners[spawner_aleatorio()].spawnear_meteorito()
	cantidad_meteoritos -= 1

func _on_detector_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)
