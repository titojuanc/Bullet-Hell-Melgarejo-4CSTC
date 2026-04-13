extends Button

@export var direccion: String

func _ready() -> void:
	pass # Replace with function body.

func _on_pressed() -> void:
	get_tree().change_scene_to_file(direccion)
	pass 
