extends Node2D

@onready var camera = $Camera
@onready var background = %ColorRect

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		print("open pause menu")
		%PauseMenu.visible = true
		get_tree().paused = true

func _ready() -> void:
	pass
	#background.size = camera.get_window().size
	#background.position = Vector2(background.size.x/2*-1, background.size.y/2*-1)
