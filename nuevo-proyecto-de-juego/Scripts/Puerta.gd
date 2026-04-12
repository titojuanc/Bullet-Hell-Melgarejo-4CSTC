extends StaticBody2D

func _on_jugador_entro_arena() -> void:
	set_collision_mask_value(1, true)
	set_collision_mask_value(4, true)
	set_collision_layer_value(1, true)
	set_collision_layer_value(4, true)
	
	pass # Replace with function body.
