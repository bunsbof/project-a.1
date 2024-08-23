extends Area2D

@onready var hand_or_tongue = $"../../HandOrTongue"
@onready var right_spank_col = $RightSpankCol

var cursor_in_spanking = false
var dragging = false
var spank_released = false
signal right_spank_released 

func update_frame(cursor_position):
	var shape = right_spank_col.shape
	var width = 0
	var total_frames = 7
	if shape is RectangleShape2D:
		var rectangle_shape = shape
		width = rectangle_shape.extents.x * 2
	var mouse_frame = int(round((cursor_position / width) * (total_frames))) - 2
	mouse_frame = clamp(mouse_frame, 0, total_frames - 1)
	#print(mouse_frame)
	hand_or_tongue.set_frame(mouse_frame)

func _input(event):
	if event is InputEventMouseButton and cursor_in_spanking:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		var x_coordinate = local_position.x
		update_frame(x_coordinate)
	elif event.is_released() and dragging:
		dragging = false
		cursor_in_spanking = false
		spank_released = true
		emit_signal("right_spank_released")


func _on_mouse_entered():
	cursor_in_spanking = true


func _on_mouse_exited():
	cursor_in_spanking = dragging
