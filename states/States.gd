extends Node
class_name State

signal Transitioned(previous_state: State, new_state_name: String)


func Enter():
	pass

func Exit():
	pass

func Update(delta: float) -> void:
	pass
