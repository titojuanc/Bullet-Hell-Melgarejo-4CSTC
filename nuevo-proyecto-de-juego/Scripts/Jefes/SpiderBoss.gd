extends "res://Bases/Jefe.gd"

func _configurar_jefe() -> void:
	vidamax=90
	vida=vidamax
	jugador = ControlGlobal.jugador
	disparo = preload("res://Objetos/Proyectiles/Telarana.tscn")
	velocidad = 4
	movimiento_time = 3
