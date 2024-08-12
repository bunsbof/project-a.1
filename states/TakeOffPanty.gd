extends State
class_name TakeOffPanty

@export var pant_sprite: NodePath
@export var panty_sprite: NodePath
@export var area_control_clothes: NodePath
@export var switch_back: State
@export var service_tool: NodePath

var pant : AnimatedSprite2D
var panty : AnimatedSprite2D
var control
var hands : AnimatedSprite2D

func _ready():
	pant = get_node(pant_sprite)
	panty = get_node(panty_sprite)
	control = get_node(area_control_clothes)
	hands = get_node(service_tool)

func _physics_process(delta):
	if (control.dragging or control.cursor_in_clothes) and panty.visible:
		Transitioned.emit(switch_back, "TakeOffPanty")
	else:
		Transitioned.emit(self, "Idle")

func enter():
	hands.animation = "hands_removing_panty" 
	hands.visible = true
	panty.animation = "removing"
	control.which_cloth = panty

func exit():
	hands.visible = false
