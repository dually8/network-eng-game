extends Control

func _on_ready() -> void:
	$VBoxContainer/StartBtn.grab_focus()

func _on_start_btn_pressed() -> void:
	print("start game")
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _on_quit_btn_pressed() -> void:
	print("quit game")
	get_tree().quit()
