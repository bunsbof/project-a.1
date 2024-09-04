extends AnimatedSprite2D
#
#var twitch_timer : Timer
#var twitch_interval : float = 1.0  # Average interval between twitches in seconds
#var twitch_variation : float = 0.5  # Variation in seconds
#var current_states = {}
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	## Initialize the Twitch Timer
	#twitch_timer = Timer.new()
	#twitch_timer.one_shot = true
	#add_child(twitch_timer)
	#twitch_timer.connect("timeout", Callable(self, "_on_twitch_timer_timeout"))
#
#func _start_twitching(states : Array):
	#current_states = states
	## Ensure the timer is only started once and not repeatedly
	#if not twitch_timer.is_stopped():
		#return
	## Start the twitch timer with a random interval
	#self.animation = "twitch"
	#var random_interval = twitch_interval + randf_range(-twitch_variation, twitch_variation)
	#twitch_timer.start(random_interval)
#
#func _on_twitch_timer_timeout():
	#var twitch = false
	## Queue another twitch if the condition is still true
	#for state in current_states:
		#if state in ["clitcaress", "clitlick", "pussyfingering", "cunnilingus", "analfingering", "anallick"]:
			#twitch = true
			## Play the twitch animation
			#self.play("twitch")
			#break
	#if twitch:
		#_start_twitching(current_states)
	#elif !twitch:
		##self.stop()
		#twitch_timer.stop()
#
#func set_states(states: Array):
	#current_states = states
