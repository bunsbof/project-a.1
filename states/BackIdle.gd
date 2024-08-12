extends State
class_name BackIdle

@export var body_sprite: NodePath
@export var area_control_clothes: NodePath
var clothes_control
var body : AnimatedSprite2D

func _ready():
	body = get_node(body_sprite)
	clothes_control = get_node(area_control_clothes)

func enter():
	body.play("idle")

func exit():
	body.stop()
