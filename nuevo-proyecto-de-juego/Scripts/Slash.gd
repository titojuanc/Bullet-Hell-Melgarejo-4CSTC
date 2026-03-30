extends RigidBody2D

const VELOCIDAD = 600.0

func _ready() -> void:
	var direccion = (get_global_mouse_position() - global_position).normalized()
	linear_velocity = direccion * VELOCIDAD
	await get_tree().create_timer(2.0).timeout
	queue_free()
