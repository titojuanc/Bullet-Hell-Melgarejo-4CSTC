extends "res://Bases/Jugador.gd"
@onready var flecha = preload("res://Objetos/Proyectiles/Flecha.tscn")

func configurar_personaje() -> void:
	velocidad = 300.0
	vidamax = 3
	vida = vidamax
	Slash = preload("res://Objetos/Proyectiles/Slash.tscn")
	ataque_cooldown = 0.8
	habilidad_cooldown = 2
	animador.sprite_frames = preload("res://Assets/Soldier/Soldier_spriteFrame.tres")

func _habilidad() -> void:
	habilidad_en_uso = true
	var ulti = flecha.instantiate()
	add_child(flecha)
	ulti.position = Vector2.ZERO
	animador.stop()
	animador.play("Habilidad")
	en_cooldown_habilidad=true
	cooldown_habilidad.start()
