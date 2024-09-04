extends Node
class_name State

var mood : bool
var earn_weight : int
var sequence : int
var max_duration : float
var mood_percentage : int
var earn_rate : int

signal Transitioned(previous_state: State, new_state_name: String)


func Enter():
	pass

func Exit():
	pass

func Update(delta: float) -> void:
	pass

func on_trust_changed():
	pass
