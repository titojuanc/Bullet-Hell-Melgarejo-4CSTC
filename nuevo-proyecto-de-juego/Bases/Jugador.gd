extends CharacterBody2D

#señales para comunicarse con otros objetos
signal murio
signal entro_arena
signal recibio_dano

#estas variables cambian según el personaje elegido.
var velocidad
var vidamax
var Slash
var ataque_cooldown
var habilidad_cooldown = 3
var vida

#estados del pj
var atacando = false
var muerto = false
var dañado = false
var en_cooldown = false
var en_cooldown_habilidad = false
var stun = false
var en_combate = false 
var habilidad_en_uso = false

#hijos necesarios a modificar
@onready var animador: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown: Timer = $Cooldown
@onready var tiempo_stun: Timer = $Stun
@onready var cooldown_habilidad: Timer = $Cooldown_habilidad

func _enter_tree() -> void:
	set_script(ControlGlobal.jugador_seleccionado)

func _ready() -> void:
	configurar_personaje()
	ControlGlobal.jugador = self
	
	#configura sus cooldown
	animador.animation_finished.connect(_on_ataque_terminado)
	animador.animation_finished.connect(_on_habilidad_terminado)
	cooldown_habilidad.one_shot = true
	cooldown.one_shot = true
	cooldown_habilidad.wait_time = habilidad_cooldown
	cooldown.wait_time = ataque_cooldown
	cooldown.timeout.connect(func(): en_cooldown = false)
	cooldown_habilidad.timeout.connect(func(): en_cooldown_habilidad = false)
	#para setear la barra
	recibio_dano.emit(vidamax, vidamax)

func _process(delta: float) -> void:
	if global_position.x > -500 and en_combate == false:
		entro_arena.emit()
		en_combate=true

func _physics_process(delta: float) -> void:
	#prioridad 1: muerto
	if muerto:
		animador.play("Muerte")
		return
	
	var collsion = move_and_collide(velocity * delta)
	#Le creo un vector de movimiento para hacerla más fácil
	var direccion = Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down")).normalized()
	velocity = direccion * velocidad
	
	if collsion:
		if (collsion.get_collider().is_in_group("Bala") or 
		   collsion.get_collider().is_in_group("Jefe")) and stun == false:
			recibir_daño()
			
	if direccion.x != 0:
		animador.flip_h = direccion.x < 0
		
	#prioridad 2: stun
	if stun:
		animador.play("Danado")
		return
	
	#prioridad 3: habilidad, despues ataque
	if Input.is_action_pressed("attack") and !en_cooldown and !habilidad_en_uso:
			_atacar()
			return
	
	if Input.is_action_pressed("ability") and !en_cooldown_habilidad:
			print("LLegue")
			_habilidad()
			return
	
	#bloquea el ataque de vuelta, medido por cooldown
	if atacando or habilidad_en_uso:
			return 
	#para poder chequear de manera mas simple qe animacion hace
	animador.play("Walk" if direccion != Vector2.ZERO else "Idle")

func recibir_daño() -> void:
	vida -= 1
	tiempo_stun.start()
	recibio_dano.emit(vida, vidamax)
	if vida != 0:
		stun = true
	elif vida == 0:
		morir()

func morir() -> void:
	muerto = true
	murio.emit()

func _on_ataque_terminado() -> void:
	if animador.animation == "Shoot":
		atacando = false

func _on_habilidad_terminado() -> void:
	if animador.animation == "Habilidad":
		habilidad_en_uso = false

func _on_stun_timeout() -> void:
	stun = false
	pass

func _atacar() -> void:
	atacando = true
	var bullet = Slash.instantiate()
	add_child(bullet)
	bullet.position = Vector2.ZERO
	animador.stop()
	animador.play("Shoot")
	en_cooldown = true
	cooldown.start()

func _habilidad() -> void:
	pass

func configurar_personaje() -> void:
	pass
