extends RigidBody2D

const velocidad = 600.0

func _ready() -> void:
	
	var direccion = (get_global_mouse_position() - global_position).normalized()
	linear_velocity = direccion * velocidad
	await get_tree().create_timer(2.0).timeout
	queue_free()	
