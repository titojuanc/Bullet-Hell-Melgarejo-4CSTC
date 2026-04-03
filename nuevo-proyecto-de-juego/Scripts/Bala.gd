extends RigidBody2D

const velocidad = 600

func _process(delta: float) -> void:
	linear_velocity = Vector2.RIGHT.rotated(rotation) * velocidad
	await get_tree().create_timer(2.0).timeout
	queue_free()
