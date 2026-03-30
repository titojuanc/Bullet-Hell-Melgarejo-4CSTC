extends CharacterBody2D

@export var vida = 3

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if vida == 0:
		queue_free()


func _physics_process(delta: float) -> void:
	var colision = move_and_collide(velocity)
	if colision:
		var bala = colision.get_collider()
		bala.queue_free()
		vida -= 1
	pass
