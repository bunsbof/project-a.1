extends Area2D

@onready var pant = $"../Pant"
@onready var panty = $"../Panty"
@onready var clothes_action_col = $ClothesActionCol
@onready var clothes_area = $".."
@onready var hand_or_tongue = $"../../HandOrTongue"

var dragging = false
var which_cloth
var cursor_in_clothes = false
var mouse_frame = 0
var total_frames

func _ready():
	total_frames = (11 if which_cloth == pant else 13) + 1
	which_cloth = pant if pant.visible == true else panty if panty.visible == true else null
	
func _process(delta):
	clothes_area.visible = pant.visible or panty.visible
	which_cloth = pant if pant.visible == true else panty if panty.visible == true else null

func update_frame(cursor):
	var shape = clothes_action_col.shape
	var height = 0
	if shape is RectangleShape2D:
		var rectangle_shape = shape
		height = rectangle_shape.extents.y * 2
	mouse_frame = int(round((cursor / height) * (total_frames))) + 4
	#print(which_cloth)
	if which_cloth:
		which_cloth.set_frame(mouse_frame)
		hand_or_tongue.set_frame(mouse_frame)
	#print(which_cloth)
	if which_cloth == pant and mouse_frame >= total_frames and pant.visible:
		dragging = false
		Global.pant_visibility = false
	elif which_cloth == panty and mouse_frame >= total_frames and !pant.visible:
		Global.panty_visibility = false

func _input(event):
	if event is InputEventMouseButton and cursor_in_clothes:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				dragging = true
		elif event.is_released() and dragging:
			dragging = false
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		var y_coordinate = local_position.y
		update_frame(y_coordinate)

func _on_mouse_entered():
	cursor_in_clothes = true

func _on_mouse_exited():
	cursor_in_clothes = dragging
