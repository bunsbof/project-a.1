extends State

@export_group("Related Group")
@export var control_node : NodePath
@export var face_node : NodePath
@export var shirt_node : NodePath
@export var breast_node : NodePath
@export var switch_back : State

var animation_names

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
	Data.connect("horny_level_changed", Callable(self, "_on_horny_level_changed"))
	_on_horny_level_changed(Data.horny_level)

func _physics_process(delta):
	if Global.front_state == self.name.to_lower():
		Transitioned.emit(switch_back, self.name)
	else:
		Transitioned.emit(self, switch_back.name)

func enter():
	face.animation = animation_names[1]

func _on_hover_shirt():
	face.play(animation_names[1])

func _on_being_takeoff():
	face.play(animation_names[0])

func _on_slow_takeoff():
	face.play(animation_names[1])

func _on_frame_changed():
	if breast.animation == "breast_bounce" and breast.frame > 0 and breast.is_playing():
		face.play(animation_names[2])
	elif breast.animation == "breast_bounce" and breast.frame == 0 and !breast.is_playing():
		face.play(animation_names[1])

func _on_face_finished():
	if face.animation == animation_names[2]:
		face.play(animation_names[1])

func _on_horny_level_changed(new_horny_level):
	animation_names = [
		"shirt_touch_A_%d" % new_horny_level,
		"shirt_touch_B_%d" % new_horny_level,
		"shirt_touch_C_%d" % new_horny_level
	]

func exit():
	face.animation = animation_names[1]
