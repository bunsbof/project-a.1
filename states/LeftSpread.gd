extends State

@onready var clothes_area = $"../../ClothesArea"

@export_group("Related Node")
@export var left_spread_control : NodePath
@export var hands_sprite : NodePath
@export var switch_back : State
@export var pussy_sprite: NodePath
@export var collision_node : NodePath

var control_node : Area2D
var hands : AnimatedSprite2D
var pussy : AnimatedSprite2D
var collision : CollisionShape2D
var timer: Timer

func _ready():
	control_node = get_node(left_spread_control)
	hands = get_node(hands_sprite)
	pussy = get_node(pussy_sprite)
	collision = get_node(collision_node)
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)


func _physics_process(delta):
	collision.disabled = clothes_area.visible
	if (control_node.dragging or control_node.cursor_in_spread):
		Transitioned.emit(switch_back, "LeftSpread")
	elif Global.spread_at_frame == 0:
		Transitioned.emit(self, "Idle")

func enter():
	hands.animation = "hand_spread"
	hands.visible = true
	pussy.animation = "spread"
	pussy.set_frame(Global.spread_at_frame)
	hands.set_frame(Global.spread_at_frame)
	var back_state_machine = get_parent()
	back_state_machine.previous_state = self

func exit():
	if Global.back_state == "idle":
		timer.start()
	else:
		hands.visible = false
		pussy.animation = "idle"

func _on_timer_timeout():
	hands.visible = false
	pussy.animation = "idle"
	timer.stop()
