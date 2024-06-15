class_name GameManager extends Node

func pause_game():
  get_tree().paused = true

func unpause_game():
  get_tree().paused = false
