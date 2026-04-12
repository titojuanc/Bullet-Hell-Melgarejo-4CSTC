extends Camera2D

@export var objetivo_1: CharacterBody2D
@export var objetivo_2: CharacterBody2D


func _on_jugador_entro_arena() -> void:
	limit_bottom= 800
	limit_top= -1000
	limit_right= 1600
	limit_left = -500
	pass # Replace with function body.
