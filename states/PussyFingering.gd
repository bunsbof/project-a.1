extends State

@export var vagaga_sprite_control : NodePath
@export var hand_sprite : NodePath
@export var pussy_sprite: NodePath
@export var collision_node : NodePath
@export var switch_back : State
@export var body_sprite : NodePath

var control_node : Area2D
var hand : AnimatedSprite2D
var pussy : AnimatedSprite2D
var collision : CollisionShape2D
var body : AnimatedSprite2D

func _ready():
	control_node = get_node(vagaga_sprite_control)
	hand = get_node(hand_sprite)
	pussy = get_node(pussy_sprite)
	collision = get_node(collision_node)
	body = get_node(body_sprite)

func _physics_process(delta):
	# Disability of both clit caress and clit lick state (only one area to control both but different state for save time)
	collision.disabled = !((!Global.lickable and Global.spread_at_frame == 0) or (Global.lickable and Global.spread_at_frame == 5)) or !Global.front_state == "idle"
	if (control_node.dragging or control_node.cursor_in_vagaga) and !Global.lickable and Global.spread_at_frame == 0:
		Transitioned.emit(switch_back, "PussyFingering")
	else:
		Transitioned.emit(self, "Idle")

func Update(delta):
	body._start_twitching([self.name.to_lower()])

func enter():
	hand.animation = "hand_fingering_vag"
	hand.visible = true
	pussy.animation = "idle"

func exit():
	hand.visible = false
	pussy.animation = "idle"
	body.set_states(["idle"])
