extends Node

var shirt_frame = 0
var spread_at_frame = 0
var lickable = false

var back_state
var front_state

var shirt_visibility = true
var pant_visibility = true
var panty_visibility = true

var already_seen = {
	"jobs" : false
}

signal shirt_on_off
