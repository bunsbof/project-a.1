extends State
class_name BackIdle

@export var body_sprite: NodePath
@export var pussy_sprite: NodePath
@export var hand_sprite: NodePath

var body : AnimatedSprite2D
var pussy : AnimatedSprite2D
var hand : AnimatedSprite2D

func _ready():
	body = get_node(body_sprite)
	pussy = get_node(pussy_sprite)
	hand = get_node(hand_sprite)

func enter():
	body.animation = "idle"
	pussy.animation = "idle"
	#hand.visible = false
	#hand.animation = "hands_idle"
	#body.play("idle")

func exit():
	body.stop()
