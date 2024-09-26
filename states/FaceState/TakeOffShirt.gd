extends State

@export_group("Related Group")
@export var control_node : NodePath
@export var face_node : NodePath
@export var shirt_node : NodePath
@export var breast_node : NodePath

var animation_names = ["shirt_touch_A_1", "shirt_touch_B_1", "shirt_touch_C_1"]

var control : Area2D
var face : AnimatedSprite2D
var shirt : AnimatedSprite2D
var breast : AnimatedSprite2D

func _ready():
	control = get_node(control_node)
	face = get_node(face_node)
	shirt = get_node(shirt_node)
	breast = get_node(breast_node)
	control.connect("hover_shirt", Callable(self, "_on_hover_shirt"))
	control.connect("being_take_off", Callable(self, "_on_being_takeoff"))
	control.connect("slow_take_off", Callable(self, "_on_slow_takeoff"))
	breast.connect("frame_changed", Callable(self, "_on_frame_changed"))
	face.connect("animation_finished", Callable(self, "_on_face_finished"))

func enter():
	face.animation = animation_names[1]

func _on_hover_shirt():
	face.play(animation_names[1])

func _on_being_takeoff():
	face.play(animation_names[0])

func _on_slow_takeoff():
	face.play(animation_names[1])

func _on_frame_changed():
	if breast.animation == "breast_bounce" and breast.frame > 0:
		face.play(animation_names[2])
	elif breast.animation == "breast_bounce" and breast.frame == 0:
		face.play(animation_names[1])

func _on_face_finished():
	if face.animation == animation_names[2]:
		face.play(animation_names[1])

func exit():
	face.animation = animation_names[1]
