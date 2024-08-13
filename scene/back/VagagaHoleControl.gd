extends Area2D

@onready var hand_or_tongue = $"../../HandOrTongue"
@onready var vagaga_hole_col = $VagagaHoleCol

var cursor_in_vagaga = false
var dragging = false

func update_frame(cursor_position):
	var shape = vagaga_hole_col.shape
	var width = 0
	var total_frames = 4
	if shape is RectangleShape2D:
		var rectangle_shape = shape
		width = rectangle_shape.extents.x * 2
	var mouse_frame = 4 - (int(round((cursor_position.y / width) * (total_frames - 1))) + 4)
	mouse_frame = clamp(mouse_frame, 0, total_frames - 1)
	hand_or_tongue.set_frame(mouse_frame)

func _input(event):
	if event is InputEventMouseButton and cursor_in_vagaga:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		update_frame(local_position)
	elif event.is_released() and dragging:
		dragging = false
		cursor_in_vagaga = false

func _on_mouse_entered():
	cursor_in_vagaga = true

func _on_mouse_exited():
	cursor_in_vagaga = dragging
