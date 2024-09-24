extends Node

var shirt_frame = 0
var spread_at_frame = 0
var lickable = false

var back_state
var front_state

var shirt_visibility = true
var pant_visibility = true
var panty_visibility = true

var takeoffable = true :
	set(value):
		takeoffable = value
		emit_signal("offable")

var already_seen = {
	"jobs" : false
}

signal offable
signal shirt_on_off
