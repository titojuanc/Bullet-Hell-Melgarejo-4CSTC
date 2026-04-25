extends "res://Bases/Jefe.gd"

func _configurar_jefe() -> void:
	vidamax=50
	vida=vidamax
	jugador = ControlGlobal.jugador
	disparo = preload("res://Objetos/Proyectiles/Bala.tscn")
	velocidad = 5
	movimiento_time = 2
	animador.sprite_frames = preload("res://Assets/Macaw/spriteSheet_Macaw.tres")
	animador.play("Movimiento")

func _ataque_1() -> void:
	for c in rotor.get_children():
		var bala = disparo.instantiate()
		get_tree().root.add_child(bala)
		bala.position = c.global_position
		bala.rotation = c.global_rotation
	_rotar_canones()
	pass

func _ataque_2() -> void:
	for c in rotor.get_children():
		var bala = disparo.instantiate()
		get_tree().root.add_child(bala)
		bala.position = c.global_position
		bala.rotation = c.global_rotation
	_rotar_canones()
	pass

func _ataque_3() -> void:
	var c = rotor.get_child(0)
	var direccion = jugador.global_position - global_position
	c.position = Vector2(radio, 0).rotated(direccion.angle())
	c.rotation = Vector2(radio, 0).rotated(direccion.angle()).angle()
	var bala = disparo.instantiate()
	get_tree().root.add_child(bala)
	bala.position = c.global_position
	bala.rotation = c.global_rotation
	
	pass

func _moverse() -> void:
	var direccion = jugador.global_position - global_position
	velocity = Vector2(5, 0).rotated(direccion.angle())
	if direccion.x != 0:
		animador.flip_h = direccion.x < 0
