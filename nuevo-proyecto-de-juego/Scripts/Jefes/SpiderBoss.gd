extends "res://Bases/Jefe.gd"

var minion = preload("res://Objetos/Enemigo.tscn")

func _configurar_jefe() -> void:
	vidamax=90
	vida=vidamax
	jugador = ControlGlobal.jugador
	disparo = preload("res://Objetos/Proyectiles/Telarana.tscn")
	velocidad = 6
	movimiento_time = 1
	animador.sprite_frames = preload("res://Assets/SpiderBoss/spriteSheet_SpiderBoss.tres")
	animador.play("Movimiento")

func _moverse() -> void:
	var direccion = jugador.global_position - global_position
	velocity = Vector2(velocidad, 0).rotated(direccion.angle())
	if direccion.x != 0:
		animador.flip_h = direccion.x < 0

func _spawnear_minion() -> void:
	var enemigo = minion.instantiate()
	enemigo.set_script(preload("res://Scripts/Enemigos/Raptor.gd"))
	enemigo.global_position = global_position
	get_tree().root.add_child(enemigo)
	enemigo.jugador = jugador

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
	_spawnear_minion()
	pass

func _ataque_1_config() -> void:
		#configuracion del ataque 1:
	canones = 16
	grados_rotados = 12
	timer.wait_time = 3
	ataque_cooldown.wait_time = 0.5
	_generar_canones(canones)
	pass

func _ataque_2_config() -> void:
		#configuracion del ataque 2:
	canones = 4
	grados_rotados = 5
	timer.wait_time = 4
	ataque_cooldown.wait_time = 0.1
	_generar_canones(canones)
	pass

func _ataque_3_config() -> void:
	timer.wait_time = 0.3
	ataque_cooldown.stop()
	pass
