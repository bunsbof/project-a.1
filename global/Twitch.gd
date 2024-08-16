extends Node

#class_name TwitchManager
#
#var twitch_timer = Timer.new()
#var twitch_interval = 1.0  # Default interval
#var twitch_variation = 0.5
#var twitch_animation = "twitch"
#var current_states = {}
#var back_body = load("res://scene/back/back.tscn").instantiate().get_node("Body")
#
#func _init():
	#twitch_timer.connect("timeout", Callable(self, "_on_twitch_timer_timeout"))
	#add_child(twitch_timer)
##
#func _process(delta):
	#print(back_body.animation, " ", back_body.is_playing())
#
#func _start_twitching(states: Array):
	#current_states = states
#
	# Ensure the timer is only started once
	#if not twitch_timer.is_stopped() or back_body.animation == twitch_animation:
		#return
#
	#var random_interval = twitch_interval + randf_range(-twitch_variation, twitch_variation)
	#twitch_timer.start(random_interval)
#
#func _on_twitch_timer_timeout():
	#var twitch = false
	#for state in current_states:
		#if state in ["clitcaress", "clitlick", "pussyfingering", "cunnilingus", "analfingering", "anallick"]:
			#twitch = true
			#break
	#if twitch and back_body and back_body.animation != twitch_animation:
		#back_body.play(twitch_animation)
		# Queue another twitch with a random interval
		#var random_interval = twitch_interval + randf_range(-twitch_variation, twitch_variation)
		#twitch_timer.start(random_interval)
	#elif not twitch:
		#twitch_timer.stop()
#
#func set_states(states: Array):
	#current_states = states
