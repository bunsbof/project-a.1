extends State

class_name Orgasm

@export_group("Related Node")
@export var switch_back : State
@export var body_sprite : NodePath

var random_reset : int
var level: String
var body : AnimatedSprite2D
var timer: Timer

func _ready():
	random_reset = int(randf_range(40.0, 70.0))
	body = get_node(body_sprite)
	timer = Timer.new()
	timer.one_shot = true  # Ensure it runs only once per call
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)


func _physics_process(delta):
	if Data.point >= 1000:
		Transitioned.emit(switch_back, self.name)


func enter():
	var duration = on_trust_changed()  # Store duration returned from on_trust_changed
	body.play(level)
	print("Duration: ", duration)
	timer.start(duration)

func exit():
	if timer.is_stopped() == false:
		timer.stop()

func on_trust_changed():
	match Data.trust_level:
		1:
			level = "orgasm_lv1"
			return randf_range(2.0, 5.0)
		2:
			level = "orgasm_lv2"
			return randf_range(6.0, 9.0)
		3:
			level = "orgasm_lv3"
			return randf_range(6.0, 9.0)
		4:
			level = "orgasm_lv4"
			return randf_range(6.0, 9.0)
		_:
			get_tree().quit()
	return 0.0  # Fallback value, just in case

func _on_timer_timeout():
	# When the timer ends, transition back to the switch_back state
	print("Timer ended, switching state...")
	Data.point -= int((Data.point * random_reset) / 100)
	Transitioned.emit(self, switch_back.name)
