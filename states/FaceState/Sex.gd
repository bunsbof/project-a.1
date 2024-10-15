extends State

@export_group("Related Node")
@export var face_holder: NodePath
@export var switch_back : State

var sex_states : Array = ["clitcaress", "clitlick", "pussyfingering", "analfingering", "cunnilingus", "anallick", "rightthighlick", "rightsqueez", "rightpull", "leftsqueez", "leftpull", "leffgrope", "rightgrope"]
var animation_drag = ["sex_B_1", "sex_C_1"]
var animation_hover = ["sex_A_1", "sex_D_1"]
var face: AnimatedSprite2D

func _ready():
	face = get_node(face_holder)
	Global.connect("sex_dragging_changed", Callable(self, "_on_dragging_changed"))

func _physics_process(delta):
	if Global.back_state in sex_states or Global.front_state in sex_states:
		Transitioned.emit(switch_back, self.name)
	else:
		Transitioned.emit(self, switch_back.name)

func enter():
	var random_index = randi() % animation_hover.size()
	face.play(animation_hover[random_index])

func exit():
	pass
	
func _on_dragging_changed(new_value):
	if new_value:
		var random_index = randi() % animation_drag.size()
		face.play(animation_drag[random_index])
	if (Global.back_state == "spankright" or Global.back_state == "spankleft") and !Global.sex_action["dragging"]:
		Transitioned.emit(switch_back, self.name)
		
