extends Area2D

@onready var pussy = $".."
@onready var left_spread_col = $LeftSpreadCol
@onready var hand_or_tongue = $"../../HandOrTongue"
@onready var timer = $Timer

var cursor_in_spread = false
var dragging = false

func update_frame(cursor_position):
	var shape = left_spread_col.shape
	var width = 0
	var total_frames = 6
	if shape is RectangleShape2D:
		var rectangle_shape = shape
		width = rectangle_shape.extents.x * 2
	var mouse_frame = abs(int(round((cursor_position / width) * (total_frames - 1)))) - 3
	Global.spread_at_frame = clamp(mouse_frame, 0, total_frames - 1)
	pussy.set_frame(Global.spread_at_frame)
	hand_or_tongue.set_frame(Global.spread_at_frame)
	#print(spread_at_frame)

func _input(event):
	if event is InputEventMouseButton and cursor_in_spread:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		var x_coordinate = local_position.x
		update_frame(x_coordinate)
	elif event.is_released() and dragging:
		dragging = false
		if Global.spread_at_frame < 5 and !dragging:
			start_play_backward()

func _on_mouse_entered():
	cursor_in_spread = true

func _on_mouse_exited():
	cursor_in_spread = dragging and !(Global.spread_at_frame == 0 or Global.spread_at_frame == 5)

func start_play_backward():
	timer.wait_time = 0.1
	timer.start()

func _on_timer_timeout():
	if Global.spread_at_frame >= 0:
		pussy.set_frame(Global.spread_at_frame)
		Global.spread_at_frame -= 1
	else:
		if Global.spread_at_frame < 0:
			Global.spread_at_frame = 0
		timer.stop()
