extends TextureRect

func _on_jugador_murio() -> void:
	#encontre esta manera antes que un animationplayer. Me parecio mas comoda.
	var tween = create_tween()
	tween.tween_property(self, "self_modulate:a", 1.0, 1.5)
	tween.tween_property(get_child(0), "self_modulate:a", 1.0, 1.5)
	tween.tween_property(get_child(1), "modulate:a", 0.7, 1.5)
	for i in (get_child(1).get_children()):
		i.visible = true
