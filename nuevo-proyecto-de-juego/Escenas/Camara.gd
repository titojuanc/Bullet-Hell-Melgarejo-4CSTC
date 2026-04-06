extends Camera2D

@export var objetivo_1: CharacterBody2D
@export var objetivo_2: CharacterBody2D

var zoom_minimo = Vector2(0.5, 0.5)
var zoom_maximo = Vector2(1.5, 1.5)
var margen = 200

func _process(delta: float) -> void:
	var punto_medio = (objetivo_1.global_position + objetivo_2.global_position) / 2
	global_position = global_position.lerp(punto_medio, delta * 5)
	
	var distancia = objetivo_1.global_position.distance_to(objetivo_2.global_position)
	var zoom_necesario = get_viewport_rect().size.x / (distancia + margen)
	var zoom_final = clamp(zoom_necesario, zoom_minimo.x, zoom_maximo.x)
	zoom = zoom.lerp(Vector2(zoom_final, zoom_final), delta * 3)
