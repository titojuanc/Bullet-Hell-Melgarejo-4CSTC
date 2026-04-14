extends Button

@export var personaje_elegido:Script

func _on_pressed() -> void:
	var seleccion = get_tree().get_nodes_in_group("botones")
	for boton in seleccion:
		boton.disabled = true
	
	var personaje = get_parent().get_child(0)
	personaje.play("selected")
	
	ControlGlobal._establecer_jugador(personaje_elegido)
	
	await personaje.animation_finished
	get_tree().change_scene_to_file("res://Escenas/Nivel_1.tscn")
	pass 
