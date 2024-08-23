extends Node

@onready var shirt = $"../Shirt"
@onready var breast = $"../Breast"

@export var shirt_col : NodePath
@export var right_squeez_col : NodePath
@export var right_pull_col : NodePath
@export var left_squeez_col: NodePath
@export var left_pull_col: NodePath

@export var initial_state : State


var parent_state : State
var current_state : State
var states : Dictionary = {}
var state_collision_map = {}


func _ready():
	state_collision_map = {
		"idle": [get_node(shirt_col), get_node(right_squeez_col), get_node(right_pull_col), get_node(left_squeez_col), get_node(left_pull_col)],
		"takeoffshirt": [get_node(shirt_col)],
		"rightsqueez": [get_node(right_squeez_col)],
		"rightpull": [get_node(right_pull_col)],
		"leftsqueez": [get_node(left_squeez_col)],
		"leftpull": [get_node(left_pull_col)]
	}

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
	breast.visible = shirt.frame >= 11 or !shirt.visible
	if Global.back_state != "idle":
		disable_all_collisions()
	elif Global.back_state == "idle":
		enable_all_collisions(Global.front_state)

	shirt.visible = Global.shirt_visibility


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	set_state(new_state_name.to_lower())

func set_state(state_name: String):
	# Disable all collisions
	for state in state_collision_map.keys():
		for collision in state_collision_map[state]:
			collision.disabled = true
	# Enable collisions for the new state
	if state_collision_map.has(state_name):
		for collision in state_collision_map[state_name]:
			collision.disabled = false
	
	# Transition to the new state
	var new_state = states.get(state_name)
	if !new_state:
		return
	
	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
	Global.front_state = state_name


func enable_all_collisions(state_name: String):
	if state_collision_map.has(state_name):
		for collision in state_collision_map[state_name]:
			collision.disabled = false


func disable_all_collisions():
	for collision_array in state_collision_map.values():
		for collision in collision_array:
			collision.disabled = true
