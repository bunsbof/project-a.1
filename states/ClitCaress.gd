extends State

class_name ClitCaress

@export_group("Related Node")
@export var switch_back : State
@export var pussy_sprite: NodePath
@export var hands_sprite : NodePath
@export var clit_control : NodePath
@export var collision_node : NodePath
@export var body_sprite : NodePath

var control_node : Area2D
var hand : AnimatedSprite2D
var pussy : AnimatedSprite2D
var collision : CollisionShape2D
var body : AnimatedSprite2D
var data_timer : Timer
var duration_timer : Timer


var twitch_timer: Timer
var twitch_interval: float = 1.0  # Average interval between twitches in seconds
var twitch_variation: float = 0.5  # Variation in seconds

func _ready():
	control_node = get_node(clit_control)
	hand = get_node(hands_sprite)
	pussy = get_node(pussy_sprite)
	collision = get_node(collision_node)
	body = get_node(body_sprite)

	duration_timer = Timer.new()
	add_child(duration_timer)
	duration_timer.connect("timeout", Callable(self, "_on_duration"))
	
	data_timer = Timer.new()
	add_child(data_timer)
	data_timer.connect("timeout", Callable(self, "_on_calculated"))
	
	twitch_timer = Timer.new()
	twitch_timer.one_shot = true
	add_child(twitch_timer)
	twitch_timer.connect("timeout", Callable(self, "_on_twitch_timer_timeout"))
	
	control_node.connect("caress_dragged", Callable(self, "_on_dragged"))
	Data.connect("trust_level_changed", Callable(self, "on_trust_changed"))
	#on_trust_changed()

func _physics_process(delta):
	collision.disabled = !((!Global.lickable and Global.spread_at_frame == 0) or (Global.lickable and Global.spread_at_frame == 5)) and !(Global.back_state == "orgasm")
	
	if (control_node.dragging or control_node.cursor_in_clit) and !Global.lickable and Global.spread_at_frame == 0:
		Transitioned.emit(switch_back, self.name)
	else:
		Transitioned.emit(self, switch_back.name)

func enter():
	hand.animation = "hand_clit_caress"
	hand.visible = true
	pussy.animation = "clit_caress"
	on_trust_changed()


func exit():
	hand.visible = false
	pussy.animation = "idle"
	data_timer.stop()
	duration_timer.stop()
	twitch_timer.stop()


func _start_twitch_timer():
	var random_wait_time = twitch_interval + randf_range(-twitch_variation, twitch_variation)
	twitch_timer.start(random_wait_time)


func _on_twitch_timer_timeout():
	body.play("twitch")  # Trigger the twitch animation
	_start_twitch_timer()  # Restart the timer with a new random interval


func _on_dragged():
	data_timer.wait_time = sequence
	duration_timer.wait_time = max_duration
	data_timer.start()
	duration_timer.start()
	_start_twitch_timer()

func on_trust_changed():
	match Data.trust_level:
		1:
			earn_weight = 10
			earn_rate = 5
			sequence = 5
			max_duration = 10.0
			mood_percentage = 10
		2:
			earn_weight = 20
			earn_rate = 6
			sequence = 4
			max_duration = 10.0
			mood_percentage = 30
		3:
			earn_weight = 30
			earn_rate = 12
			sequence = 3
			max_duration = 10.0
			mood_percentage = 70
		4:
			earn_weight = 40
			earn_rate = 15
			sequence = 2
			max_duration = 20.0
			mood_percentage = 90
		_:
			get_tree().quit()

func _on_duration():
	# Determine mood based on random percentage
	mood = false

func _on_calculated():
	var random_value = randi() % 100
	mood = random_value < mood_percentage
	var random_adjustment = randi() % (2 * earn_rate + 1) - earn_rate
	var adjusted_earn_weight = earn_weight + random_adjustment
	if mood:
		Data.point += adjusted_earn_weight
		Data.money += adjusted_earn_weight / 2
	elif !mood:
		Data.point -= adjusted_earn_weight
		Data.money -= adjusted_earn_weight / 2
	print("Value: ", random_value, " Point: ", Data.point, " Money: ", Data.money, " Mood: ", mood, " Trust Level: ", Data.trust_level)
