extends CharacterBody2D

signal murio
signal entro_arena

#estas variables cambian según el personaje elegido.
@export var velocidad = 300.0
@export var vida = 3
@export var Slash = preload("res://Objetos/Slash.tscn")

var atacando = false
var muerto = false
var dañado = false
var en_cooldown = false
var stun = false

@onready var animador: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown: Timer = $Cooldown
@onready var tiempo_stun: Timer = $Stun

func _ready() -> void:
	animador.animation_finished.connect(_on_ataque_terminado)
	cooldown.one_shot = true
	cooldown.wait_time = 0.8  
	cooldown.timeout.connect(func(): en_cooldown = false)

func _physics_process(delta: float) -> void:
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
	
	if stun:
		animador.play("Danado")
		return
	
	if Input.is_action_pressed("attack"):
		if !en_cooldown:
			atacando = true
			var bullet = Slash.instantiate()
			add_child(bullet)
			bullet.position = Vector2.ZERO
			animador.play("Shoot")
			en_cooldown = true
			cooldown.start()
	if atacando:
			return 
	animador.play("Walk" if direccion != Vector2.ZERO else "Idle")

func _process(delta: float) -> void:
	if global_position.x > -500:
		entro_arena.emit()

func _on_ataque_terminado() -> void:
	if animador.animation == "Shoot":
		atacando = false


func _on_stun_timeout() -> void:
	stun = false
	pass # Replace with function body.

func recibir_daño() -> void:
	vida -= 1
	stun = true
	tiempo_stun.start()
	print("recibí daño")
	if vida == 0:
		muerto = true
		murio.emit()
		print("mori")
