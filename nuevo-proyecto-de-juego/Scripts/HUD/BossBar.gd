extends ProgressBar

func _on_jugador_entro_arena() -> void:
	visible=true

func _on_jefe_recibir_daño(vida, vidamax) -> void:
	max_value=vidamax
	value=vida
	pass

func _on_jefe_murio() -> void:
	queue_free()
	pass
