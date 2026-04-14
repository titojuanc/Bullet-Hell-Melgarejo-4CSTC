extends Button

func _on_pressed() -> void:
	var personaje = get_parent().get_child(0)
	personaje.play("selected")
	pass 
