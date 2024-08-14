extends State

@export var anal_sprite_control : NodePath
@export var hand_sprite : NodePath
@export var collision_node : NodePath
@export var switch_back : State

var control_node : Area2D
var hand : AnimatedSprite2D
var collision : CollisionShape2D

func _ready():
	control_node = get_node(anal_sprite_control)
	hand = get_node(hand_sprite)
	collision = get_node(collision_node)

func _physics_process(delta):
	# Disability of both clit caress and clit lick state (only one area to control both but different state for save time)
	collision.disabled = !((!Global.lickable and Global.spread_at_frame == 0) or (Global.lickable and Global.spread_at_frame == 5)) or !Global.front_state == "idle"
	if (control_node.dragging or control_node.cursor_in_anal) and !Global.lickable and Global.spread_at_frame == 0:
		Transitioned.emit(switch_back, "AnalFingering")
	else:
		Transitioned.emit(self, "Idle")

func enter():
	hand.animation = "hand_fingering_anal"
	hand.visible = true

func exit():
	hand.visible = false
