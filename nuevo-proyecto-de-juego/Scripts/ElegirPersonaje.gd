extends Button

@export var jefe_nivel_1:Script 
@export var personaje_elegido:Script

func _on_pressed() -> void:
	var seleccion = get_tree().get_nodes_in_group("botones")
	for boton in seleccion:
		boton.disabled = true
	
	var personaje = get_parent().get_child(0)
	personaje.play("selected")
	
	ControlGlobal._establecer_jugador(personaje_elegido)
	ControlGlobal._establecer_jefe(jefe_nivel_1)
	
	await personaje.animation_finished
	get_tree().change_scene_to_file("res://Escenas/Nivel_1.tscn")
	pass 
