extends State

@export_group("Related Node")
@export var switch_back : State
@export var right_thigh_control : NodePath
@export var tongue_sprite : NodePath
@export var right_thigh_col : NodePath

var control_node : Area2D
var tongue : AnimatedSprite2D
var thigh_col : CollisionShape2D
var animations_playing = 0

func _ready():
	control_node = get_node(right_thigh_control)
	tongue = get_node(tongue_sprite)
	thigh_col = get_node(right_thigh_col)
	# Connect to the spank_released signal
	control_node.connect("right_thigh_lick", Callable(self, "_on_right_thigh_lick"))

	# Connect animation_finished signals
	tongue.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta):
	thigh_col.disabled = !(Global.lickable and Global.spread_at_frame <= 0 and (Global.back_state == "rightthighlick" or Global.back_state == "idle"))
	if control_node.cursor_in_thigh:
		Transitioned.emit(switch_back, "RightThighLick")
	elif (tongue.animation == "tongue_right_thigh" and tongue.frame == 0) and !control_node.cursor_in_thigh and animations_playing <= 0:
		Transitioned.emit(self, "Idle")

func enter():
	tongue.animation = "tongue_right_thigh"
	tongue.frame = 0
	tongue.visible = true


func _on_right_thigh_lick():
	tongue.play()
	Global.set_sex_dragging(true)
	animations_playing += 1


func _on_animation_finished():
	animations_playing -= 1  # Decrement counter
	if animations_playing <= 0:
		_exit_state()

func _exit_state():
	#hand.visible = false
	Global.set_sex_dragging(false)
	Transitioned.emit(self, "Idle")


func exit():
	tongue.visible = false
