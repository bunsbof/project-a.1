extends State
class_name BackIdle

@export var body_sprite: NodePath
@export var area_control_clothes: NodePath
@export var pussy_sprite: NodePath

var clothes_control
var body : AnimatedSprite2D
var pussy : AnimatedSprite2D

func _ready():
	body = get_node(body_sprite)
	clothes_control = get_node(area_control_clothes)
	pussy =  get_node(pussy_sprite)

func enter():
	pussy.animation = "idle"
	body.play("idle")

func exit():
	body.stop()
