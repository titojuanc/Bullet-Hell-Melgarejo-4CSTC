extends Node2D

var jugador_seleccionado: Script 
var jefe_seleccionado: Script
var jugador: CharacterBody2D

func _establecer_jugador(jugador: Script) -> void:
	jugador_seleccionado=jugador
	pass

func _establecer_jefe(jefe: Script) -> void:
	jefe_seleccionado=jefe
	pass
