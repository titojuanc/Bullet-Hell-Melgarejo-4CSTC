extends CharacterBody2D

const VELOCIDAD = 200.0

@onready var animador: AnimatedSprite2D = $AnimatedSprite2D

var atacando := false

func _ready() -> void:
	animador.animation_finished.connect(_on_ataque_terminado)

func _physics_process(delta: float) -> void:
	
	var direccion := Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

	velocity = direccion * VELOCIDAD
	move_and_slide()
	
	if Input.is_action_pressed("attack"):
		atacando = true
		animador.play("Shoot")
		

	if direccion.x != 0:
		animador.flip_h = direccion.x < 0

	if atacando:
			return 
		
	animador.play("Walk" if direccion != Vector2.ZERO else "Idle")

func _on_ataque_terminado() -> void:
	if animador.animation == "Shoot":
		atacando = false
