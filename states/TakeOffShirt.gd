extends State

@export var shirt_sprite : NodePath
@export var shirt_control_node : NodePath
@export var breast_sprite : NodePath
@export var switch_back : State

var shirt : AnimatedSprite2D
var breast: AnimatedSprite2D
var control_node : Area2D
var automatic_timer : Timer
var mode : String

func _ready():
	shirt = get_node(shirt_sprite)
	breast = get_node(breast_sprite)
	control_node = get_node(shirt_control_node)
	automatic_timer = Timer.new()
	add_child(automatic_timer)
	#Connect to shirt signals
	shirt.connect("frame_changed", Callable(self, "_on_frame_changed"))
	automatic_timer.connect("timeout", Callable(self, "_on_timeout"))
	Global.shirt_on_off.connect(func():
		_on_off_shirt()
	)

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

func _on_off_shirt():
	mode = "takeoff" if Global.shirt_visibility else "puton"
	automatic_timer.wait_time = 0.1
	automatic_timer.start()


func _on_timeout():
	if mode == "takeoff":
		shirt.set_frame(Global.shirt_frame)
		Global.shirt_frame += 1
		
		if Global.shirt_frame >= 13:
			Global.shirt_frame = 12
			Global.shirt_visibility = false
			automatic_timer.stop()
	elif mode == "puton":
		# Shirt is currently not visible, so we're putting it on
		if Global.shirt_frame > 0:
			Global.shirt_visibility = true
			shirt.set_frame(Global.shirt_frame)
			Global.shirt_frame -= 1
			
			if Global.shirt_frame <= 0:
				Global.shirt_frame = 0
				Global.shirt_visibility = true
				automatic_timer.stop()

