extends State

@export var switch_back : State
@export var right_control_node : NodePath
@export var breast_sprite : NodePath

var control_node : Area2D
var breast : AnimatedSprite2D

func _ready():
	control_node = get_node(right_control_node)
	breast = get_node(breast_sprite)

func _physics_process(delta):
	if control_node.dragging or control_node.cursor_in_squeez:
		Transitioned.emit(switch_back, self.name)
	else:
		Transitioned.emit(self, switch_back.name)

func enter():
	breast.animation = "right_breast_squeeze"

func exit():
	breast.animation = "breast_bounce"
