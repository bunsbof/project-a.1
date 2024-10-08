extends Node

signal resolution_changed
signal fullscreen_changed

var file_index
var full_screen : bool:
	set(val):
		full_screen = val
		emit_signal("fullscreen_changed", val)

var resolutions : String:
	set(res):
		resolutions = res
		emit_signal("resolution_changed", res)
