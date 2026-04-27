extends CharacterBody2D

var vida
var vidamax
var velocidad
var jugador

@onready var animador: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	_configurar_enemigo()

func _physics_process(delta: float) -> void:
	var direccion = jugador.global_position - global_position
	velocity = Vector2(velocidad, 0).rotated(direccion.angle())
	if direccion.x != 0:
		animador.flip_h = direccion.x < 0
	
	var colision = move_and_collide(velocity * delta)
	if colision:
		var objeto = colision.get_collider()
		if objeto.has_method("recibir_daño"):
			jugador.recibir_daño()
		if objeto.is_in_group("Bala"):
			var dano_recibido = objeto.dano
			objeto.queue_free()
			vida -= dano_recibido
			if vida <= 0:
				queue_free()

func _configurar_enemigo() -> void:
	pass
