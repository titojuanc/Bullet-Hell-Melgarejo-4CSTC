extends CharacterBody2D

var duracion = 2.0
var velocidad = 400

func _process(delta: float) -> void:
	await get_tree().create_timer(duracion).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	velocity = Vector2.RIGHT.rotated(rotation) * velocidad
	var colision = move_and_collide(velocity * delta)
	if colision:
		var jugador = colision.get_collider()
		if jugador.has_method("recibir_daño"):
			jugador.recibir_daño()
		queue_free()
	
