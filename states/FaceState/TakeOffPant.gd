extends State

@export_group("Related Node")
@export var face_holder: NodePath
@export var switch_back : State

var animation_names = ["pant_touch_A_1", "pant_touch_B_1", "pant_touch_C_1"]
var face: AnimatedSprite2D
var is_animating = false

func _ready():
	face = get_node(face_holder)
	Global.connect("dragging_changed", Callable(self, "_on_dragging_changed"))
	Global.connect("cursor_in_clothes_changed", Callable(self, "_on_cursor_in_clothes_changed"))
	Global.connect("clothing_hidden", Callable(self, "_on_pant_off"))
	face.connect("animation_finished", Callable(self, "_on_face_finished"))

func _physics_process(delta):
	if !is_animating:
		if (Global.clothes_object["dragging"] or Global.clothes_object["cursor_in_clothes"]) and Global.clothes_object["which_clothes"].name == "Pant" and Global.back_state == self.name.to_lower():
			Transitioned.emit(switch_back, self.name)
		else:
			Transitioned.emit(self, switch_back.name)


func enter():
	pass

func exit():
	face.play(animation_names[1])


func _on_dragging_changed(new_value):
	if new_value and Global.clothes_object["which_clothes"].name == "Pant":
		face.play(animation_names[0])

func _on_cursor_in_clothes_changed(new_value):
	if new_value and not Global.clothes_object["dragging"]:
		face.play(animation_names[1])

func _on_face_finished():
	if face.animation == animation_names[2]:
		is_animating = false
		exit()

func _on_pant_off(which_clothing: String):
	if which_clothing == "pant":
		is_animating = true
		face.play(animation_names[2])
