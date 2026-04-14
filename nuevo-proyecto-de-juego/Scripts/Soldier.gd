extends "res://Bases/Jugador.gd"

func configurar_personaje() -> void:
	velocidad = 300.0
	vidamax = 3
	vida = vidamax
	Slash = preload("res://Objetos/Slash.tscn")
	ataque_cooldown = 0.8
	animador.sprite_frames = preload("res://Assets/Soldier/Soldier_spriteFrame.tres")
