extends Node

signal offable
signal shirt_on_off
signal back_state_changed
signal front_state_changed
signal dragging_changed(new_value)
signal cursor_in_clothes_changed(new_value)
signal clothing_hidden(which_clothing)
signal dragging_in_clit_changed(new_value)
signal cursor_in_clit_changed(new_value)

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


var clothes_object = {
	"dragging" : false,
	"cursor_in_clothes": false,
	"which_clothes": null,
}

var clit_object = {
	"dragging": false,
	"cursor_in_clit": false,
}

func set_dragging_clit(value):
	if clit_object["dragging"] != value:
		clit_object["dragging"] = value
		emit_signal("dragging_in_clit_changed", value)

func set_cursor_in_clit(value):
	if clit_object["cursor_in_clit"] != value:
		clit_object["cursor_in_clit"] = value
		emit_signal("cursor_in_clit_changed", value)

func set_dragging(value):
	if clothes_object["dragging"] != value:
		clothes_object["dragging"] = value
		emit_signal("dragging_changed", value)

func set_cursor_in_clothes(value):
	if clothes_object["cursor_in_clothes"] != value:
		clothes_object["cursor_in_clothes"] = value
		emit_signal("cursor_in_clothes_changed", value)

func set_pant_hidden(is_visible: bool):
	pant_visibility = is_visible
	if not is_visible:
		emit_signal("clothing_hidden", "pant")

func set_panty_hidden(is_visible: bool):
	panty_visibility = is_visible
	if not is_visible:
		emit_signal("clothing_hidden", "panty")
