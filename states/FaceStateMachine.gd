extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		Global.front_state = current_state.name.to_lower()


func _process(delta):
	if current_state:
		current_state.Update(delta)


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	set_state(new_state_name.to_lower())

func set_state(state_name: String):
	var new_state = states.get(state_name)
	if !new_state:
		return
	
	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
