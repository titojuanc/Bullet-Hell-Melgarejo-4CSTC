extends CharacterBody2D

const velocidad = 300.0

@export var vida = 3
@export var Slash = preload("res://Objetos/Slash.tscn")
@onready var animador: AnimatedSprite2D = $AnimatedSprite2D

var atacando = false
var dañado = false
var en_cooldown = false
@onready var cooldown: Timer = $Cooldown

func _ready() -> void:
	animador.animation_finished.connect(_on_ataque_terminado)
	cooldown.one_shot = true
	cooldown.wait_time = 0.8  
	cooldown.timeout.connect(func(): en_cooldown = false)

func _physics_process(delta: float) -> void:
	#Le creo un vector de movimiento para hacerla más fácil
	var direccion := Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down")).normalized()
	velocity = direccion * velocidad
	var collsion = move_and_collide(velocity * delta)
	if collsion:
		vida =- 1
		animador.play("Danado")
		if vida == 0:
			animador.play("Muerte")
		
	if Input.is_action_pressed("attack"):
		if !en_cooldown:
			atacando = true
			var bullet = Slash.instantiate()
			add_child(bullet)
			bullet.position = Vector2.ZERO
			animador.play("Shoot")
			en_cooldown = true
			cooldown.start()
	if direccion.x != 0:
		animador.flip_h = direccion.x < 0
	if atacando:
			return 
	animador.play("Walk" if direccion != Vector2.ZERO else "Idle")

func _on_ataque_terminado() -> void:
	if animador.animation == "Shoot":
		atacando = false
