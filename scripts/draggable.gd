extends Node2D

var is_draggable = false
var is_inside_dropable = false
var body_ref: StaticBody2D = null
var offset: Vector2
var initialPos: Vector2
var dropable_counter = 0

func _process(_delta: float) -> void:
	if is_draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			GameManager.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif  Input.is_action_just_released("click"):
			GameManager.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered() -> void:
	if not GameManager.is_dragging:
		is_draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited() -> void:
	if not GameManager.is_dragging:
		is_draggable = false
		scale = Vector2(1.0, 1.0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		print("is inside dropable")
		is_inside_dropable = true
		dropable_counter += 1
		body.modulate = Color(Color.GREEN, 1)
		body_ref = body as StaticBody2D

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		print("is NOT inside dropable")
		print("dropable count: " + str(dropable_counter))
		if dropable_counter <= 1:
			is_inside_dropable = false
			body_ref = body as StaticBody2D
		body.modulate = Color(Color.ROYAL_BLUE, 0.75)
		dropable_counter -= 1
