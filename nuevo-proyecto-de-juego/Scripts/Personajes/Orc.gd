extends "res://Bases/Jugador.gd"

func configurar_personaje() -> void:
	velocidad = 200
	vidamax = 6
	vida = vidamax
	Slash = preload("res://Objetos/Slash.tscn")
	ataque_cooldown = 1.5
	animador.sprite_frames = preload("res://Assets/Orc/Orc_spriteSheet.tres")
