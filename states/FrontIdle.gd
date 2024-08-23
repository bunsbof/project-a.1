extends State

@export var body_sprite: NodePath
@export var breast_sprite: NodePath
@export var shirt_sprite: NodePath

var body : AnimatedSprite2D
var breast : AnimatedSprite2D
var shirt : AnimatedSprite2D

func _ready():
	body = get_node(body_sprite)
	breast =  get_node(breast_sprite)
	shirt = get_node(shirt_sprite)
	#Connect shirt signal
	shirt.connect("visibility_changed", Callable(self, "_on_visibility_changed"))

func enter():
	breast.animation = "breast_bounce"
	if shirt.visible and shirt.frame <= 10:
		breast.frame = 0
	elif shirt.visible and shirt.frame >= 11:
		breast.frame = 6
	elif !shirt.visible:
		breast.frame = 6

func exit():
	pass

func _on_visibility_changed():
	if shirt.visible and shirt.frame <= 10:
		breast.frame = 0
	elif shirt.visible and shirt.frame >= 11:
		breast.frame = 6
	
	if !shirt.visible:
		breast.play()
