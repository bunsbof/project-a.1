extends State

@export_group("Related Node")
@export var face_holder: NodePath
var animation_names = [
		"idle_1_%d" % Data.horny_level,
		"idle_2_%d" % Data.horny_level,
		"idle_3_%d" % Data.horny_level
	]
var face: AnimatedSprite2D

func _ready():
	face = get_node(face_holder)
	face.connect("animation_finished", Callable(self, "_on_animation_finished"))
	Data.connect("horny_level_changed", Callable(self, "_on_horny_level_changed"))
	start_idle_animation()

func enter():
	start_idle_animation()

func start_idle_animation():
	# Play a random animation initially
	var random_index = randi() % animation_names.size()
	face.play(animation_names[random_index])

func _on_horny_level_changed(new_horny_level):
	animation_names = [
		"idle_1_%d" % new_horny_level,
		"idle_2_%d" % new_horny_level,
		"idle_3_%d" % new_horny_level
	]
	start_idle_animation()

func exit():
	pass
