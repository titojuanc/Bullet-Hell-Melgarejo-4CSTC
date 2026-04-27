extends "res://Bases/Enemigo.gd"

func _configurar_enemigo() -> void:
	vidamax = 5
	vida = vidamax
	velocidad = 260
	animador.sprite_frames = preload("res://Assets/SpiderBoss/raptor_spriteFrame.tres")
	animador.play("default")
