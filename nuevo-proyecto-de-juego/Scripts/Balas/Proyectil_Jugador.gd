extends RigidBody2D

class_name ProyectilJugador

var velocidad: float
var direccion: Vector2
var rotacion = 0
var dano

func _ready() -> void:
	_configurar_proyectil()
	direccion = (get_global_mouse_position() - global_position).normalized()
	linear_velocity = (direccion * velocidad).rotated(rotacion)
	await get_tree().create_timer(0.8).timeout
	queue_free()

func _cambiar_angulo(r: float) -> void:
	rotacion = r

func _configurar_proyectil() -> void:
	pass
