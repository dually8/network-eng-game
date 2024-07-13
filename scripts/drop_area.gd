class_name DropArea extends StaticBody2D

func _ready() -> void:
	modulate = Color(Color.ROYAL_BLUE, 0.75)

func _process(_delta: float) -> void:
	if GameManager.is_dragging:
		visible = true
	else:
		visible = false
