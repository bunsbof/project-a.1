extends State

@export var switch_back : State
@export var pussy_sprite: NodePath
@export var hands_sprite : NodePath
@export var clit_control : NodePath
@export var collision_node : NodePath

var control_node : Area2D
var hand : AnimatedSprite2D
var pussy : AnimatedSprite2D
var collision : CollisionShape2D

func _ready():
	control_node = get_node(clit_control)
	hand = get_node(hands_sprite)
	pussy = get_node(pussy_sprite)
	collision = get_node(collision_node)

func _physics_process(delta):
	# Disability of both clit caress and clit lick state (only one area to control both but different state for save time)
	collision.disabled = !((!Global.lickable and Global.spread_at_frame == 0) or (Global.lickable and Global.spread_at_frame == 5)) or !Global.front_state == "idle"
	
	if (control_node.dragging or control_node.cursor_in_clit) and !Global.lickable and Global.spread_at_frame == 0:
		Transitioned.emit(switch_back, "ClitCaress")
	else:
		Transitioned.emit(self, "Idle")

func enter():
	hand.animation = "hand_clit_caress"
	hand.visible = true
	pussy.animation = "clit_caress"

func exit():
	hand.visible = false
	pussy.animation = "idle"
