extends "res://Bases/Jugador.gd"



func configurar_personaje() -> void:
	velocidad = 300.0
	vidamax = 3
	vida = vidamax
	Slash = preload("res://Objetos/Proyectiles/Slash.tscn")
	ataque_cooldown = 0.8
	animador.sprite_frames = preload("res://Assets/Soldier/Soldier_spriteFrame.tres")

func _habilidad() -> void:
	habilidad_en_uso = true
	animador.stop()
	animador.play("Habilidad")
	en_cooldown_habilidad=true
	cooldown_habilidad.start()
