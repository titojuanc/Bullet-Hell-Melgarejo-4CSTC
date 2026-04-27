extends "res://Bases/Enemigo.gd"

func _configurar_enemigo() -> void:
	jugador = ControlGlobal.jugador
	vidamax = 5
	vida = vidamax
	velocidad = 4
	animador.sprite_frames = preload("res://Assets/SpiderBoss/raptor_spriteFrame.tres")
	animador.play("default")
