extends State
class_name TakeOffPant

@export_group("Related Node")
@export var pant_sprite: NodePath
@export var area_control_clothes: NodePath
@export var switch_back: State
@export var service_tool: NodePath

var pant : AnimatedSprite2D
var hands : AnimatedSprite2D
var control : Area2D

func _ready():
	pant = get_node(pant_sprite)
	control = get_node(area_control_clothes)
	hands = get_node(service_tool)

func _physics_process(delta):
	#print(control.dragging, " ",control.cursor_in_clothes)
	if (control.dragging or control.cursor_in_clothes) and pant.visible:
		Transitioned.emit(switch_back, "TakeOffPant")
	else:
		Transitioned.emit(self, "Idle")


func enter():
	hands.animation = "hands_removing_pant" 
	hands.visible = true
	pant.animation = "removing"
	control.which_cloth = pant

func exit():
	hands.visible = false
