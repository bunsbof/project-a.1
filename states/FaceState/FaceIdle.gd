extends State

@export var face_holder: NodePath
var animation_names = ["idle_1_1", "idle_2_1", "idle_3_1"]
var face: AnimatedSprite2D

func _ready():
	face = get_node(face_holder)
	face.connect("animation_finished", Callable(self, "_on_animation_finished"))
	start_idle_animation()

func start_idle_animation():
	# Play a random animation initially
	var random_index = randi() % animation_names.size()
	face.play(animation_names[random_index])
