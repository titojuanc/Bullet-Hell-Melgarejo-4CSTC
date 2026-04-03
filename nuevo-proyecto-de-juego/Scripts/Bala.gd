extends RigidBody2D

const velocidad = 600

func _process(delta: float) -> void:
	position += transform.x * velocidad * delta
	await get_tree().create_timer(2.0).timeout
	queue_free()
