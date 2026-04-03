extends CharacterBody2D

#variables para los ataques (cambian según el ataque)
var velocidad_giro = 40
var cooldown = 2
var cañones = 8
var radio = 10
var disparo = preload("res://Objetos/Bala.tscn")
var atacando = false

#variables de nodos hijos
@onready var ataque_cooldown = $Ataque_Cooldown
@onready var timer = $Cooldown
@onready var rotor = $Rotor

#variables con export (para saber la vida o dónde está el jugador)
@export var vida = 10
@export var jugador: CharacterBody2D

func _ready() -> void:
	_generar_canones(cañones)

	timer.wait_time = cooldown
	timer.start()
	pass

func _process(delta: float) -> void:
	if vida == 0:
		queue_free()

func _physics_process(delta: float) -> void:
	var colision = move_and_collide(velocity)
	if colision:
		var objeto = colision.get_collider()
		objeto.queue_free()
		vida -= 1
	
	
	var rotacion_actual = rotor.rotation_degrees + velocidad_giro * delta
	#fmod hace que la rotación no se vaya a más de 360 (si rota siempre al mismo lado los grados se van hasta infinito)
	rotor.rotation_degrees = fmod(rotacion_actual, 360)
	pass

func _on_cooldown_timeout() -> void:
	if atacando == false:
		#acá iría una selección aleatoria de ataques, por ahora solo hace uno
		timer.wait_time = 5
		timer.start()
		#esto se setea por cada ataque individualmente. algunos disparan más rápido, otros más lento
		ataque_cooldown.wait_time = 0.3
		ataque_cooldown.start()
		atacando = true
	else:
		atacando = false
		timer.wait_time = 2
		timer.start()
		ataque_cooldown.stop()
		_moverse()

func _on_ataque_cooldown_timeout() -> void:
	#debería poder saber qué ataque se está ejecutando
	_ataque_1()
	pass

func _ataque_1() -> void:
	for c in rotor.get_children():
		var bala = disparo.instantiate()
		get_tree().root.add_child(bala)
		bala.position = c.global_position
		bala.rotation = c.global_rotation
	pass

func _generar_canones(num_canones: int) -> void:
	#acá preparo los cañones. La variable distancia es un ángulo.
	var distancia = 2 * PI/num_canones
	
	for i in range(cañones):
		var cañon = Node2D.new()
		# se crea un vector desde el centro del enemigo hasta el borde del 
		# círculo, y luego se va rotando por cada iteración para
		# cubrir todo el circulo.
		var pos = Vector2(radio, 0).rotated(distancia * i)
		cañon.position = pos
		cañon.rotation = pos.angle()
		rotor.add_child(cañon)

func _resetear_canones() -> void:
	for canon in rotor.get_children():
		canon.queue_free()

func _moverse() -> void:
	move_and_collide(velocity)
