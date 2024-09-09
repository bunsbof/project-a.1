extends Area2D

@onready var shirt = $".."
@onready var shirt_collision = $ShirtCollision
@onready var breast = $"../../Breast"

var cursor_in_shirt = false
var takeOffWaitTime : Timer

func _ready():
	takeOffWaitTime = Timer.new()
	add_child(takeOffWaitTime)
	takeOffWaitTime.connect("timeout", Callable(self, "_on_timeout"))

func update_frame(cursor_position):
	var shape = shirt_collision.shape
	var height = 0
	var total_frames = 13
	
	if shape is RectangleShape2D:
		var rectangle_shape = shape
		height = rectangle_shape.extents.y * 2
	
	if cursor_position >= 0 and cursor_position < height / 2:
		# Clicked above the shirt, decrease current frame
		Global.shirt_frame -= 2
		if Global.shirt_frame < 0:
			Global.shirt_frame = 0
	elif cursor_position >= height / 2:
		# Clicked below the shirt, increase current frame
		Global.shirt_frame += 2
		if Global.shirt_frame >= total_frames:
			Global.shirt_frame = total_frames - 1  # Ensure it caps at the max frame
	#print(Global.shirt_frame)
	shirt.set_frame(Global.shirt_frame)
	if shirt.frame >= 12:
		takeOffWaitTime.wait_time = 0.6
		takeOffWaitTime.start()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and cursor_in_shirt:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var local_position = to_local(event.position)
			var y_coordinate = local_position.y
			update_frame(y_coordinate)


func _on_mouse_entered():
	cursor_in_shirt = true


func _on_mouse_exited():
	cursor_in_shirt = false

func _on_timeout():
	Global.shirt_visibility = false
	takeOffWaitTime.stop()
