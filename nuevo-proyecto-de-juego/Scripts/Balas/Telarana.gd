extends CharacterBody2D

var velocidad = 400

func _physics_process(delta: float) -> void:
	velocity = Vector2.RIGHT.rotated(rotation) * velocidad
	var colision = move_and_collide(velocity * delta)
	if colision:
		var jugador = colision.get_collider()
		if jugador.has_method("recibir_daño"):
			jugador.recibir_daño()
		queue_free()
