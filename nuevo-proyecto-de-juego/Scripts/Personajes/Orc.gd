extends "res://Bases/Jugador.gd"

func configurar_personaje() -> void:
	velocidad = 250
	vidamax = 6
	vida = vidamax
	Slash = preload("res://Objetos/Proyectiles/OrcSlash.tscn")
	ataque_cooldown = 1.5
	animador.sprite_frames = preload("res://Assets/Orc/Orc_spriteSheet.tres")

func _atacar() -> void:
	atacando = true
	var i=0
	var bullet
	var angulo = -0.6
	while i<5:
		bullet = Slash.instantiate()
		bullet._cambiar_angulo(angulo)
		add_child(bullet)
		bullet.position = Vector2.ZERO
		angulo = angulo + 0.3
		i=i+1
	animador.stop()
	animador.play("Shoot")
	en_cooldown = true
	cooldown.start()

func _habilidad() -> void:
	habilidad_en_uso = true
	animador.stop()
	animador.play("Habilidad")
	en_cooldown_habilidad=true
	cooldown_habilidad.start()
