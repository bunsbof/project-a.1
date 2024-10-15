extends State

@export_group("Related Node")
@export var switch_back : State
@export var control : NodePath
@export var hand_sprite : NodePath
@export var body_sprite : NodePath

var control_node : Area2D
var hand : AnimatedSprite2D
var body : AnimatedSprite2D

func _ready():
	control_node = get_node(control)
	hand = get_node(hand_sprite)
	body = get_node(body_sprite)

func _physics_process(delta):
	if (control_node.dragging or control_node.cursor_in_grope):
		Transitioned.emit(switch_back, self.name)
	else:
		Transitioned.emit(self, switch_back.name)

func enter():
	hand.animation = "hand_right_grope"
	hand.frame = 0
	hand.visible = true
	body.animation = "right_ass_grope"
	body.frame = 0


func exit():
	hand.visible = false
	body.animation = "idle"
