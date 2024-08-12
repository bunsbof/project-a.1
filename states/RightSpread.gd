extends State

@export var right_spread_control : NodePath
@export var hands_sprite : NodePath
@export var switch_back : State
@export var pussy_sprite: NodePath

var control_node : Area2D
var hands : AnimatedSprite2D
var pussy : AnimatedSprite2D

func _ready():
	control_node = get_node(right_spread_control)
	hands = get_node(hands_sprite)
	pussy = get_node(pussy_sprite)


func _physics_process(delta):
	if (control_node.dragging or control_node.cursor_in_spread) or (Global.spread_at_frame >= 5):
		Transitioned.emit(switch_back, "RightSpread")
	else:
		Transitioned.emit(self, "Idle")

func enter():
	hands.animation = "hand_spread"
	hands.visible = true
	pussy.animation = "spread"
	pussy.set_frame(Global.spread_at_frame)
	hands.set_frame(Global.spread_at_frame)

func exit():
	if control_node.timer.is_stopped():
		hands.visible = false
		pussy.animation = "idle"
