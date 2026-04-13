extends CharacterBody2D

signal murio
signal recibir_daño

#variables para los ataques (cambian según el ataque)
var grados_rotados
var cooldown = 2
var canones
var radio = 10
var atacando = false
var ataque_seleccionado

#variables de nodos hijos
@onready var ataque_cooldown = $Ataque_Cooldown
@onready var timer = $Cooldown
@onready var rotor = $Rotor
@onready var animador = $AnimatedSprite2D

#variables con export para parametrizar
@export var vidamax: int
var vida=10
@export var jugador: CharacterBody2D
@export var disparo = preload("res://Objetos/Bala.tscn")
@export var velocidad = 5

func _ready() -> void:
	recibir_daño.emit(vida, vidamax)
	timer.wait_time = cooldown
	timer.start()
	pass

func _physics_process(delta: float) -> void:
	var colision = move_and_collide(velocity)
	if colision:
		if colision.get_collider().is_in_group("Bala"):
			var objeto = colision.get_collider()
			objeto.queue_free()
			vida -= 1
			recibir_daño.emit(vida, vidamax)
			print(vida)
			if vida == 0:
				murio.emit()
				queue_free()
