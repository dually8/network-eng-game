class_name LineController extends Node2D

@export var line_width: float = 4.0
@export var line_color: Color = Color(1, 0, 0)
@export var point_size: float = 100.0 # Size for hit detection

@onready var line: Line2D = %Line2D
@onready var pointA: Node2D = %PointA
@onready var pointB: Node2D = %PointB
@onready var areaA: Area2D = %PointA/Area2D
@onready var areaB: Area2D = %PointB/Area2D

var dragging_point: Node2D = null
var point_area: Area2D = null

func _ready() -> void:
	line.default_color = line_color
	line.width = line_width
	update_line()
	add_indicator(pointA)
	add_indicator(pointB)
	areaA.area_entered.connect(_on_area_enteredA)
	areaA.area_exited.connect(_on_area_exitedA)
	areaB.area_entered.connect(_on_area_enteredB)
	areaB.area_exited.connect(_on_area_exitedB)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if _is_mouse_over_point(pointA, event.global_position):
					dragging_point = pointA
				elif _is_mouse_over_point(pointB, event.global_position):
					dragging_point = pointB
			else:
				if point_area != null:
					dragging_point.global_position = point_area.global_position
				else:
					check_for_area_point_overlap()
				print("drag point is null")
				dragging_point = null
				_set_point_area(null)
	elif event is InputEventMouseMotion and dragging_point:
		dragging_point.global_position += event.relative
		update_line()

func update_line() -> void:
	line.clear_points()
	line.add_point(to_local(pointA.global_position))
	line.add_point(to_local(pointB.global_position))

func get_children_in_group(node: Node2D, group_name: String) -> Array:
	var children = []
	for child in node.get_children():
		if child.is_in_group(group_name):
			children.append(child)
	return children

func _is_mouse_over_point(point: Node2D, mouse_position: Vector2) -> bool:
	var local_mouse_position = to_local(mouse_position)
	var half_size = point_size / 2
	var point_rect = Rect2(point.position - Vector2(half_size, half_size), Vector2(point_size, point_size))

	return point_rect.has_point(local_mouse_position)

func check_for_area_point_overlap() -> void:
	var drag_area: Area2D = dragging_point.get_node_or_null("Area2D")
	if drag_area != null and drag_area.get_overlapping_areas().size() > 0:
		var droppable_area: Area2D = drag_area.get_overlapping_areas()[0]
		dragging_point.global_position = droppable_area.global_position

func create_indicator() -> ColorRect:
	var color_rect: ColorRect = ColorRect.new()
	color_rect.color = Color(0, 1, 0, 0.5)
	color_rect.custom_minimum_size = Vector2(point_size, point_size)
	color_rect.position = -Vector2(point_size / 2, point_size / 2)
	return color_rect

func add_indicator(point: Node2D) -> void:
	point.add_child(create_indicator())

func _on_area_enteredA(area: Area2D) -> void:
	print("on area A entered -> " + area.name)
	_set_point_area(area)

func _on_area_exitedA(area: Area2D) -> void:
	print("on area A exited -> " + area.name)
	_set_point_area(null)

func _on_area_enteredB(area: Area2D) -> void:
	print("on area B entered -> " + area.name)
	_set_point_area(area)

func _on_area_exitedB(area: Area2D) -> void:
	print("on area B exited -> " + area.name)
	_set_point_area(null)

func _set_point_area(area: Area2D) -> void:
	if area != null:
		print("set point area " + area.name)
	else:
		print("set point area to null")
	point_area = area
