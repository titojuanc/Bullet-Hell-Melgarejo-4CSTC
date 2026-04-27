extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_h_slider_value_changed(new_value: float) -> void:
	value = new_value
