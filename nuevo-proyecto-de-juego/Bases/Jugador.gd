extends CharacterBody2D

#señales para comunicarse con otros objetos
signal murio
signal entro_arena
signal recibio_dano

#estas variables cambian según el personaje elegido.
@export var velocidad = 300.0
@export var vidamax = 3
@export var Slash = preload("res://Objetos/Slash.tscn")
@export var ataque_cooldown: float

#estados del pj
var atacando = false
var muerto = false
var dañado = false
var en_cooldown = false
var stun = false
var en_combate = false 
var vida = vidamax

#hijos necesarios a modificar
@onready var animador: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown: Timer = $Cooldown
@onready var tiempo_stun: Timer = $Stun

func _ready() -> void:
	animador.animation_finished.connect(_on_ataque_terminado)
	cooldown.one_shot = true
	cooldown.wait_time = ataque_cooldown
	cooldown.timeout.connect(func(): en_cooldown = false)
	#para setear la barra
	recibio_dano.emit(vidamax, vidamax)

func _process(delta: float) -> void:
	if global_position.x > -500 and en_combate == false:
		entro_arena.emit()
		en_combate=true

func _physics_process(delta: float) -> void:
	#prioridad 1: muerto
	if muerto:
		animador.play("Muerte")
		return
	
	var collsion = move_and_collide(velocity * delta)
	#Le creo un vector de movimiento para hacerla más fácil
	var direccion = Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down")).normalized()
	velocity = direccion * velocidad
	
	if collsion:
		if (collsion.get_collider().is_in_group("Bala") or 
		   collsion.get_collider().is_in_group("Jefe")) and stun == false:
			recibir_daño()
		   
			
	if direccion.x != 0:
		animador.flip_h = direccion.x < 0
		
	#prioridad 2: stun
	if stun:
		animador.play("Danado")
		return
	
	#prioridad 3: ataque
	if Input.is_action_pressed("attack"):
		if !en_cooldown:
			atacando = true
			var bullet = Slash.instantiate()
			add_child(bullet)
			bullet.position = Vector2.ZERO
			animador.play("Shoot")
			en_cooldown = true
			cooldown.start()
	#bloquea el ataque de vuelta, medido por cooldown
	if atacando:
			return 
	#para poder chequear de manera mas simple qe animacion hace
	animador.play("Walk" if direccion != Vector2.ZERO else "Idle")

func recibir_daño() -> void:
	vida -= 1
	tiempo_stun.start()
	recibio_dano.emit(vida, vidamax)
	if vida != 0:
		stun = true
	elif vida == 0:
		morir()

func morir() -> void:
	muerto = true
	murio.emit()

func _on_ataque_terminado() -> void:
	if animador.animation == "Shoot":
		atacando = false

func _on_stun_timeout() -> void:
	stun = false
	pass
