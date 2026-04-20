extends Area2D

@onready var animador: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	look_at(get_global_mouse_position())
	animador.animation_finished.connect(_on_default_terminado)
	animador.play("default")
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bala"):
		body.queue_free()

func _on_default_terminado() -> void:
	queue_free()
