extends Control


func _on_ready() -> void:
	%ResumeBtn.grab_focus()


func _on_resume_btn_pressed() -> void:
	print("pressed resume")
	self.visible = false
	get_tree().paused = false


func _on_quit_btn_pressed() -> void:
	print("pressed quit")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
