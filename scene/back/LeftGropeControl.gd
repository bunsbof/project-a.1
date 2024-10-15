extends Area2D

@onready var left_grope_col = $LeftGropeCol
@onready var body = $"../../Body"
@onready var hand_or_tongue = $"../../HandOrTongue"

var cursor_in_grope = false
var dragging = false


func update_frame(cursor_position):
	var centered = left_grope_col.position
	var local_position = Vector2(cursor_position.x, cursor_position.y)
	var angle = atan2(local_position.y - centered.y, local_position.x - centered.x)
	if angle < 0:
		angle += 2 * PI
	var frame_fraction = 2 * PI / 10
	var frame_index = int(angle / frame_fraction) % 10
	body.set_frame(frame_index)
	hand_or_tongue.set_frame(frame_index)

func _input(event):
	if event is InputEventMouseButton and cursor_in_grope:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			Global.set_sex_dragging(dragging)
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		update_frame(local_position)
	elif event.is_released() and dragging:
		dragging = false
		cursor_in_grope = false
		Global.set_sex_dragging(dragging)

func _on_mouse_entered():
	cursor_in_grope = true

func _on_mouse_exited():
	cursor_in_grope = dragging
