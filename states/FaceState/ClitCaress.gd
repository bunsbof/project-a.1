extends State

@export_group("Related Node")
@export var face_holder: NodePath
@export var switch_back : State

var animation_drag = ["sex_B_1", "sex_C_1"]
var animation_hover = ["sex_A_1", "sex_D_1"]
var face: AnimatedSprite2D
var is_animating = false

# Called when the node enters the scene tree for the first time.
func _ready():
	face = get_node(face_holder)
	Global.connect("dragging_in_clit_changed", Callable(self, "_on_dragging_in_clit_changed"))
	Global.connect("cursor_in_clit_changed", Callable(self, "_on_cursor_in_clit_changed"))

func _physics_process(delta):
	if ((Global.clit_object["dragging"] or Global.clit_object["cursor_in_clit"]) and Global.spread_at_frame == 0 and !Global.lickable and Global.back_state == self.name.to_lower()):
		Transitioned.emit(switch_back, self.name)
	else:
		Transitioned.emit(self, switch_back.name)

func enter():
	pass

func exit():
	pass
	
func _on_dragging_in_clit_changed(new_value):
	if new_value:
		var random_index = randi() % animation_drag.size()
		face.play(animation_drag[random_index])

func _on_cursor_in_clit_changed(new_value):
	if new_value and not Global.clit_object["dragging"]:
		var random_index = randi() % animation_hover.size()
		face.play(animation_hover[random_index])
