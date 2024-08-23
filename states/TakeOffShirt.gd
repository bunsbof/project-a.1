extends State

@export var shirt_sprite : NodePath
@export var shirt_control_node : NodePath
@export var breast_sprite : NodePath
@export var switch_back : State

var shirt : AnimatedSprite2D
var breast: AnimatedSprite2D
var control_node : Area2D

func _ready():
	shirt = get_node(shirt_sprite)
	breast = get_node(breast_sprite)
	control_node = get_node(shirt_control_node)
	#Connect to shirt signals
	shirt.connect("frame_changed", Callable(self, "_on_frame_changed"))

func _physics_process(delta):
	#print(control_node.cursor_in_shirt)
	if control_node.cursor_in_shirt and shirt.visible:
		Transitioned.emit(switch_back, "TakeOffShirt")
	else:
		Transitioned.emit(self, "Idle")

func enter():
	shirt.frame = Global.shirt_frame

func exit():
	pass

func _on_frame_changed():
	if shirt.frame >= 11:
		breast.play("breast_bounce")
	if shirt.frame <= 10:
		breast.frame = 0
