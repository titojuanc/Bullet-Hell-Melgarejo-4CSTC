extends "res://Bases/Jugador.gd"

var invencible = false

func configurar_personaje() -> void:
	velocidad = 400.0
	vidamax = 2
	vida = vidamax
	Slash = preload("res://Objetos/Proyectiles/Cuchillo.tscn")
	ataque_cooldown = 0.5
	habilidad_cooldown = 2
	animador.sprite_frames = preload("res://Assets/Rouge/rouge_spriteSheet.tres")

func _habilidad() -> void:
	habilidad_en_uso = true
	invencible = true
	velocidad = 800
	animador.stop()
	animador.play("Habilidad")
	en_cooldown_habilidad=true
	cooldown_habilidad.start()

func _on_habilidad_terminado() -> void:
	if animador.animation == "Habilidad":
		habilidad_en_uso = false
		invencible = false
		velocidad = 400

func recibir_daño() -> void:
	if invencible:
		return
	vida -= 1
	tiempo_stun.start()
	recibio_dano.emit(vida, vidamax)
	if vida != 0:
		stun = true
	elif vida == 0:
		morir()
