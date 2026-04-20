extends "res://Bases/Jugador.gd"

func configurar_personaje() -> void:
	velocidad = 400.0
	vidamax = 2
	vida = vidamax
	Slash = preload("res://Objetos/Proyectiles/Cuchillo.tscn")
	ataque_cooldown = 0.5
	animador.sprite_frames = preload("res://Assets/Rouge/rouge_spriteSheet.tres")
