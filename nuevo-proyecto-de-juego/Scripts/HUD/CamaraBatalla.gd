extends Camera2D

@export var jugador: CharacterBody2D
@export var jefe: CharacterBody2D

var en_arena = false

func _process(delta: float) -> void:
	if not en_arena:
		return
	
	if not is_instance_valid(jugador):
		position = jefe.global_position
		zoom = Vector2.ONE
		return
	
	if not is_instance_valid(jefe):
		position = jugador.global_position
		zoom = Vector2.ONE
		return
	
	var punto_medio = (jugador.global_position + jefe.global_position) / 2.0
	global_position = punto_medio
	actualizar_zoom()

func actualizar_zoom() -> void:
	var distancia = jugador.global_position.distance_to(jefe.global_position)
	#clamp limita los valores que puede dar el zoom calculado. Así marco el máximo y mínimo.
	var zoom_objetivo = clamp(2.0 - (distancia / 1000.0), 0.6, 1.0)
	zoom = Vector2.ONE * zoom_objetivo

func _on_jugador_entro_arena() -> void:
	en_arena=true
	limit_bottom= 800
	limit_top= -1000
	limit_right= 1600
	limit_left = -500
	pass


func _on_jefe_murio() -> void:
	var scriptCamara: Script = preload("res://Scripts/HUD/CamaraJugador.gd")
	var camara_nueva = Camera2D.new()
	camara_nueva.set_script(scriptCamara)
	get_parent().add_child(camara_nueva)
	queue_free()
	pass
