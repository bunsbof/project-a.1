extends Node

signal trust_level_changed
signal point_changed

var trust_level = 1:
	set(value):
		trust_level = value
		emit_signal("trust_level_changed")

var point: float = 70:
	set(value):
		point = value
		emit_signal("point_changed", point)
var money: float = 2146
