extends State

@export var face_holder: NodePath
var animation_names = ["idle_1", "idle_2", "idle_3"]
var face: AnimatedSprite2D

func _ready():
	face = get_node(face_holder)
	face.connect("animation_finished", Callable(self, "_on_animation_finished"))
	start_idle_animation()

func start_idle_animation():
	# Play a random animation initially
	var random_index = randi() % animation_names.size()
	face.play(animation_names[random_index])

func _on_animation_finished():
	# Switch to a random animation when the current one finishes
	var random_index = randi() % animation_names.size()
	face.play(animation_names[random_index])

	# Optionally, you can add a delay before starting a new animation
	# This can be controlled by a timer if needed
