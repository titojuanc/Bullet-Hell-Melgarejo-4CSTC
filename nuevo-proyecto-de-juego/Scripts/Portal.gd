extends Area2D

@export var siguiente_nivel: String
var encima = false
@onready var canvas: CanvasLayer = $CanvasLayer

func _ready() -> void:
	visible=false
	canvas.visible = false

func _process(delta: float) -> void:
	if encima:
		if Input.is_action_pressed("f"):
			get_tree().change_scene_to_file(siguiente_nivel)
			print("lo hice")

func _on_jefe_murio() -> void:
	visible=true
	pass

func _on_body_entered(body: Node2D) -> void:
	canvas.visible = true
	encima = true
	

func _on_body_exited(body: Node2D) -> void:
	canvas.visible = false
	encima = false
