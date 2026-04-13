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

func _on_cooldown_timeout() -> void:
	if atacando == false:
		velocity = Vector2.ZERO
		_configurar_ataque()
		atacando = true
	else:
		ataque_cooldown.stop()
		atacando = false
		_resetear_canones()
		timer.wait_time = 2
		timer.start()
		_moverse()

func _configurar_ataque() -> void:
	var n = randi_range(1,3)
	if n == 1:
		ataque_seleccionado = 1
		
		#configuracion del ataque 1:
		canones = 8
		grados_rotados = 10
		timer.wait_time = 5
		ataque_cooldown.wait_time = 0.2
	elif n == 2:
		ataque_seleccionado = 2
		
		#configuracion del ataque 2:
		canones = 4
		grados_rotados = 5
		timer.wait_time = 3
		ataque_cooldown.wait_time = 0.1
	elif n == 3:
		ataque_seleccionado = 3
		
		#configuracion del ataque 3:
		canones = 3
		grados_rotados = 0
		timer.wait_time = 5
		ataque_cooldown.wait_time = 0.2
	_generar_canones(canones)
	timer.start()
	ataque_cooldown.start()
	pass

func _on_ataque_cooldown_timeout() -> void:
	if ataque_seleccionado == 1:
		_ataque_1()
	elif ataque_seleccionado == 2:
		_ataque_2()
	elif ataque_seleccionado == 3:
		_ataque_3()
	pass

func _ataque_1() -> void:
	pass
func _ataque_2() -> void:
	pass
func _ataque_3() -> void:
	pass

func _generar_canones(num_canones: int) -> void:
	#acá preparo los canones. La variable distancia es un ángulo.
	var distancia = 2 * PI/num_canones
	
	for i in range(canones):
		var cañon = Node2D.new()
		# se crea un vector desde el centro del enemigo hasta el borde del 
		# círculo, y luego se va rotando por cada iteración para
		# cubrir todo el circulo de manera simetrica.
		var pos = Vector2(radio, 0).rotated(distancia * i)
		cañon.position = pos
		cañon.rotation = pos.angle()
		rotor.add_child(cañon)

func _resetear_canones() -> void:
	for canon in rotor.get_children():
		canon.queue_free()
	rotor.rotation_degrees = 0

func _rotar_canones() -> void:
	var rotacion_actual = rotor.rotation_degrees + grados_rotados
	#fmod hace que la rotación no se vaya a más de 360 (si rota siempre al mismo lado los grados se van hasta infinito)
	rotor.rotation_degrees = fmod(rotacion_actual, 360)

func _moverse() -> void:
	pass
