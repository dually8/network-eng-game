extends Node2D

var is_dragging = false

func pause_game() -> void:
	get_tree().paused = true

func unpause_game() -> void:
	get_tree().paused = false

func set_dragging(_is_dragging: bool) -> void:
	is_dragging = _is_dragging
