extends State

@export var switch_back : State
@export var right_control_node : NodePath
@export var breast_sprite : NodePath

var control_node : Area2D
var breast : AnimatedSprite2D
var animations_playing = 0

func _ready():
	control_node = get_node(right_control_node)
	breast = get_node(breast_sprite)
	control_node.connect("right_pull", Callable(self, "_on_right_pull"))
	breast.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta):
	if control_node.cursor_in_pull:
		Transitioned.emit(switch_back, self.name)
	elif !control_node.clicked:
		Transitioned.emit(self, switch_back.name)

func enter():
	breast.animation = "right_breast_pull"

func exit():
	breast.animation = "breast_bounce"

func _on_right_pull():
	breast.play()
	animations_playing += 1

func _on_animation_finished():
	animations_playing -= 1  # Decrement counter
	if animations_playing <= 0:
		_exit_state()

func _exit_state():
	control_node.clicked = false
	control_node.cursor_in_pull = false
	Transitioned.emit(self, switch_back.name)
