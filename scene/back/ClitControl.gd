extends Area2D

@onready var pussy = $".."
@onready var hand_or_tongue = $"../../HandOrTongue"
@onready var clit_col = $ClitCol

var cursor_in_clit = false
var dragging = false

signal caress_dragged
signal lick_dragged

func update_frame(cursor_position):
	var centered = clit_col.position
	var local_position = Vector2(cursor_position.x, cursor_position.y)
	var angle = atan2(local_position.y - centered.y, local_position.x - centered.x)
	if angle < 0:
		angle += 2 * PI
	if Global.spread_at_frame == 0 and !Global.lickable:
		var frame_fraction = 2 * PI / 7
		var frame_index = 7 - int(angle / frame_fraction) % 7
		pussy.set_frame(frame_index)
		hand_or_tongue.set_frame(frame_index)
	elif Global.spread_at_frame == 5 and Global.lickable:
		var frame_fraction = 2 * PI / 6
		var frame_index = (6 - int(angle / frame_fraction) % 6) - 1
		#print(frame_index)
		pussy.set_frame(frame_index)
		hand_or_tongue.set_frame(frame_index)

func _input(event):
	if event is InputEventMouseButton and cursor_in_clit:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			Global.set_sex_dragging(dragging)
			if Global.spread_at_frame == 0 and !Global.lickable:
				emit_signal("caress_dragged")
			elif Global.spread_at_frame == 5 and Global.lickable:
				emit_signal("lick_dragged")
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		update_frame(local_position)
	elif event.is_released() and dragging:
		dragging = false
		cursor_in_clit = false
		Global.set_sex_dragging(dragging)

func _on_mouse_entered():
	cursor_in_clit = true

func _on_mouse_exited():
	cursor_in_clit = dragging
