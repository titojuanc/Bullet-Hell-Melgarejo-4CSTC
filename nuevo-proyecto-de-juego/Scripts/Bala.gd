extends RigidBody2D

const velocidad = 200

func _process(delta: float) -> void:
	linear_velocity = Vector2.RIGHT.rotated(rotation) * velocidad
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	var colision = move_and_collide(linear_velocity * delta)
	if colision:
		queue_free()
