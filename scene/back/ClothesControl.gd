extends Area2D

@onready var pant = $"../Pant"
@onready var panty = $"../Panty"
@onready var clothes_action_col = $ClothesActionCol
@onready var clothes_area = $".."
@onready var hand_or_tongue = $"../../HandOrTongue"

var dragging = false
var which_cloth :
	set(value):
		which_cloth = value
		Global.clothes_object["which_clothes"] = value

var cursor_in_clothes = false
var mouse_frame = 0
var total_frames

func _ready():
	Global.connect("offable", Callable(self, "_on_handled_changed"))

func _process(delta):
	clothes_area.visible = pant.visible or panty.visible
	which_cloth = pant if pant.visible == true else panty if panty.visible == true else null
	Global.set_dragging(dragging)
	Global.set_cursor_in_clothes(cursor_in_clothes)
	
	#if which_cloth != null:
		#Global.clothes_object["which_clothes"] = which_cloth

func update_frame(cursor):
	var shape = clothes_action_col.shape
	var height = 0
	which_cloth = pant if pant.visible else panty
	if shape is RectangleShape2D:
		var rectangle_shape = shape
		height = rectangle_shape.extents.y * 2
	total_frames = (11 if which_cloth == pant else 13) + 1
	#mouse_frame = clamp(int(round((cursor / height) * total_frames)), 0, total_frames - 1)
	mouse_frame = int(round((cursor / height) * total_frames)) + 4
	if which_cloth:
		which_cloth.set_frame(mouse_frame)
		hand_or_tongue.set_frame(mouse_frame)
	if which_cloth == pant and mouse_frame >= total_frames - 1 and pant.visible:
		dragging = false
		cursor_in_clothes = false
		Global.pant_visibility = false
		Global.set_pant_hidden(false)
	elif which_cloth == panty and mouse_frame >= total_frames - 1 and !pant.visible:
		dragging = false
		cursor_in_clothes = false
		Global.panty_visibility = false
		Global.set_panty_hidden(false)

func _input(event):
	if event is InputEventMouseButton and cursor_in_clothes:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				dragging = true
				Global.set_dragging(dragging)
		elif event.is_released() and dragging:
			dragging = false
			cursor_in_clothes = false
	if dragging and event is InputEventMouseMotion:
		var local_position = to_local(event.position)
		var y_coordinate = local_position.y
		update_frame(y_coordinate)

func _on_mouse_entered():
	cursor_in_clothes = true
	Global.set_cursor_in_clothes(cursor_in_clothes)

func _on_mouse_exited():
	cursor_in_clothes = dragging

func _on_handled_changed():
	self.visible = Global.takeoffable

