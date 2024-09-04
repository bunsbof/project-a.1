extends State

class_name ClitLick

@export_group("Related Node")
@export var pussy_sprite : NodePath
@export var tongue_sprite : NodePath
@export var clit_control : NodePath
@export var collision_node : NodePath
@export var body_sprite : NodePath

#var twitch_manager: TwitchManager
var control_node : Area2D
var tongue : AnimatedSprite2D
var pussy : AnimatedSprite2D
var collision : CollisionShape2D
var body : AnimatedSprite2D

func _ready():
	control_node = get_node(clit_control)
	tongue = get_node(tongue_sprite)
	pussy = get_node(pussy_sprite)
	collision = get_node(collision_node)
	body = get_node(body_sprite)

func _physics_process(delta):
	#print(body.animation, " ", body.is_playing())
	var back_state_machine = get_parent()
	var previous_state = back_state_machine.get_previous_state()
	if (control_node.dragging or control_node.cursor_in_clit) and Global.lickable and Global.spread_at_frame == 5:
		Transitioned.emit(previous_state, self.name)
	else:
		Transitioned.emit(self, previous_state.name)

func enter():
	tongue.animation = "tongue_clit_lick"
	tongue.visible = true
	pussy.animation = "clit_lick"


func exit():
	tongue.visible = false
	pussy.animation = "spread"
	body.animation = "idle"
