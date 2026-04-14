extends Node2D

@export var jefe_de_nivel: Script

func _ready() -> void:
	var nodos_hijos = get_children()
	for hijo in nodos_hijos:
		if hijo.is_in_group("Jugador"):
			print("Encontré al jugador")
			hijo.set_script(ControlGlobal.jugador_seleccionado)
			hijo
		if hijo.is_in_group("Jefe"):
			print("Encontré al jefe")
			hijo.set_script(jefe_de_nivel)
