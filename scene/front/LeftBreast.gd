extends Area2D

@onready var breast = $".."
@onready var left_breast_squeeze_col = $LeftBreastSqueezeCol

signal left_pull
var clicked = false
var cursor_in_squeez = false
var cursor_in_pull = false
var dragging = false

func update_frame(cursor_position):
	var centered = left_breast_squeeze_col.position
	var local_position = Vector2(cursor_position.x, cursor_position.y)
	var angle = atan2(local_position.y - centered.y, local_position.x - centered.x)
	if angle < 0:
		angle += 2 * PI
	var frame_fraction = 2 * PI / 9
	var frame_index = 9 - (int(angle / frame_fraction) % 9)
	#print(frame_index)
	breast.set_frame(frame_index)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if cursor_in_squeez:
				dragging = true
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and cursor_in_pull:
			clicked = true
			emit_signal("left_pull")
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		update_frame(local_position)
	elif event.is_released() and dragging:
		dragging = false
		cursor_in_squeez = false
		#print(cursor_in_squeez)



func _on_mouse_shape_entered(shape_idx):
	if shape_idx == 0:
		cursor_in_squeez = true
		#print("Cursor in Squeez: ", cursor_in_squeez)
	elif shape_idx == 1:
		cursor_in_pull = true
		#print("Cursor in Pull: ", cursor_in_pull)


func _on_mouse_shape_exited(shape_idx):
	if shape_idx == 0:
		cursor_in_squeez = dragging
		#print("Cursor in Squeez: ", cursor_in_squeez)
	elif shape_idx == 1:
		cursor_in_pull = false
		#print("Cursor in Pull: ", cursor_in_pull)

