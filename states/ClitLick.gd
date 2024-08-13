extends State

@export var switch_back : State
@export var pussy_sprite: NodePath
@export var tongue_sprite : NodePath
@export var clit_control : NodePath
@export var collision_node : NodePath

var control_node : Area2D
var tongue : AnimatedSprite2D
var pussy : AnimatedSprite2D
var collision : CollisionShape2D

func _ready():
	control_node = get_node(clit_control)
	tongue = get_node(tongue_sprite)
	pussy = get_node(pussy_sprite)
	collision = get_node(collision_node)

func _physics_process(delta):
	#print(control_node.dragging, " ", control_node.cursor_in_clit)
	if (control_node.dragging or control_node.cursor_in_clit) and Global.lickable and Global.spread_at_frame == 5:
		Transitioned.emit(switch_back, "ClitLick")
	else:
		Transitioned.emit(self, "RightSpread")

func enter():
	tongue.animation = "tongue_clit_lick"
	tongue.visible = true
	pussy.animation = "clit_lick"

func exit():
	tongue.visible = false
	pussy.animation = "spread"
