extends State

@export var switch_back : State
@export var body_sprite : NodePath
@export var pant_sprite : NodePath
@export var panty_sprite : NodePath
@export var spank_control : NodePath
@export var hand_sprite : NodePath

var body : AnimatedSprite2D
var pant : AnimatedSprite2D
var panty : AnimatedSprite2D
var control_node : Area2D
var hand : AnimatedSprite2D
var pussy : AnimatedSprite2D
var animations_playing = 0

func _ready():
	body = get_node(body_sprite)
	pant = get_node(pant_sprite)
	panty = get_node(panty_sprite)
	control_node = get_node(spank_control)
	hand = get_node(hand_sprite)
	# Connect to the spank_released signal
	control_node.connect("left_spank_released", Callable(self, "_on_spank_released"))

	# Connect animation_finished signals
	body.connect("animation_finished", Callable(self, "_on_animation_finished"))
	pant.connect("animation_finished", Callable(self, "_on_animation_finished"))
	panty.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta):
	if control_node.dragging or control_node.cursor_in_spanking:
		Transitioned.emit(switch_back, "SpankLeft")
	elif hand.animation == "hand_spank_left" and hand.frame == 0:
		Transitioned.emit(self, "Idle")

func enter():
	hand.animation = "hand_spank_left"
	hand.frame = 0
	hand.visible = true


func _on_spank_released():
	hand.visible = false
	body.animation = "spanked_left"
	body.play()
	animations_playing += 1

	if pant.visible:
		pant.animation = "spanked_left"
		pant.play()
		animations_playing += 1
	if panty.visible:
		panty.animation = "spanked_left"
		panty.play()
		animations_playing += 1

func _on_animation_finished():
	animations_playing -= 1  # Decrement counter
	if animations_playing <= 0:
		_exit_state()

func _exit_state():
	#hand.visible = false
	Transitioned.emit(self, "Idle")


func exit():
	hand.visible = false
