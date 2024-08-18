extends Area2D

var cursor_in_thigh = false
signal right_thigh_lick

func _input(event):
	if event is InputEventMouseButton and cursor_in_thigh:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			emit_signal("right_thigh_lick")

func _on_mouse_entered():
	cursor_in_thigh = true

func _on_mouse_exited():
	cursor_in_thigh = false
