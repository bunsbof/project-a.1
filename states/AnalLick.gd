extends State

@export var tongue_sprite : NodePath
@export var anal_control : NodePath
@export var collision_node : NodePath
@export var pussy_sprite : NodePath

var control_node : Area2D
var tongue : AnimatedSprite2D
var collision : CollisionShape2D
var pussy : AnimatedSprite2D

func _ready():
	control_node = get_node(anal_control)
	tongue = get_node(tongue_sprite)
	collision = get_node(collision_node)
	pussy = get_node(pussy_sprite)

func _physics_process(delta):
	#print(control_node.dragging, " ", control_node.cursor_in_clit)
	var back_state_machine = get_parent()
	var previous_state = back_state_machine.get_previous_state()
	if (control_node.dragging or control_node.cursor_in_anal) and Global.lickable and Global.spread_at_frame == 5:
		Transitioned.emit(previous_state, "AnalLick")
	else:
		Transitioned.emit(self, previous_state.name)

func enter():
	tongue.animation = "tongue_anal"
	tongue.visible = true
	pussy.animation = "spread_idle"

func exit():
	tongue.visible = false
	pussy.animation = "spread"
