extends CharacterBody2D

#variables para los ataques (cambian según el ataque)
var grados_rotados
var cooldown = 2
var canones
var radio = 10
var disparo = preload("res://Objetos/Bala.tscn")
var atacando = false
var ataque_seleccionado
var velocidad = 5

#variables de nodos hijos
@onready var ataque_cooldown = $Ataque_Cooldown
@onready var timer = $Cooldown
@onready var rotor = $Rotor

#variables con export para parametrizar
@export var vida = 10
@export var jugador: CharacterBody2D

func _ready() -> void:
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
	pass

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
	for c in rotor.get_children():
		var bala = disparo.instantiate()
		get_tree().root.add_child(bala)
		bala.position = c.global_position
		bala.rotation = c.global_rotation
	_rotar_canones()
	pass

func _ataque_2() -> void:
	for c in rotor.get_children():
		var bala = disparo.instantiate()
		get_tree().root.add_child(bala)
		bala.position = c.global_position
		bala.rotation = c.global_rotation
	_rotar_canones()
	pass

func _ataque_3() -> void:
	var c = rotor.get_child(0)
	var direccion = jugador.global_position - global_position
	c.position = Vector2(radio, 0).rotated(direccion.angle())
	c.rotation = Vector2(radio, 0).rotated(direccion.angle()).angle()
	var bala = disparo.instantiate()
	get_tree().root.add_child(bala)
	bala.position = c.global_position
	bala.rotation = c.global_rotation
	
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
	var direccion = jugador.global_position - global_position
	velocity = Vector2(5, 0).rotated(direccion.angle())
	
	
