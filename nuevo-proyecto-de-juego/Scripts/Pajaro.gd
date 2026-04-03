extends CharacterBody2D
var velocidad_giro = 45
var cooldown = 1
var cañones = 4
var radio = 30
var disparo = preload("res://Objetos/Bala.tscn")
@export var vida = 3
@onready var timer = $Cooldown
@onready var rotor = $Rotor

func _ready() -> void:
	#acá preparo los cañones. La variable distancia es un ángulo.
	var distancia = 2 * PI/cañones
	
	for i in range(cañones):
		var cañon = Node2D.new()
		# se crea un vector desde el centro del enemigo hasta el borde del 
		# círculo, y luego se va rotando por cada iteración para
		# cubrir todo el circulo.
		var pos = Vector2(radio, 0).rotated(distancia * i)
		cañon.position = pos
		cañon.rotation = pos.angle()
		rotor.add_child(cañon)
	
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

#cuando el cooldown termine:
func _on_cooldown_timeout() -> void:
	for c in rotor.get_children():
		var bala = disparo.instantiate()
		get_tree().root.add_child(bala)
		bala.position = c.global_position
		bala.rotation = c.global_rotation
	pass
