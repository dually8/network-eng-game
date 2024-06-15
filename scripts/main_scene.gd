extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		print("open pause menu")
		%PauseMenu.visible = true
		get_tree().paused = true
