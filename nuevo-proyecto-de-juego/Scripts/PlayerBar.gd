extends ProgressBar

func _ready() -> void:
	step = 1.0
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_jugador_recibio_dano(vida, vidamax) -> void:
	max_value = vidamax
	value = vida
	pass 
