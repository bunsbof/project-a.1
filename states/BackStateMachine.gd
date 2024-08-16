extends Node

@onready var pussy = $"../Pussy"
@onready var clothes_area = $"../ClothesArea"
@onready var anal_control = $"../AnalControl"

@export var clothes_col : NodePath
@export var left_spread_col : NodePath
@export var right_spread_col : NodePath
@export var clit_col : NodePath
@export var vagaga_hole_col: NodePath
@export var anal_col: NodePath

@export var initial_state : State

var parent_state : State
var current_state : State
var states : Dictionary = {}
var state_collision_map = {}
var previous_state : State
#var twitch_manager: TwitchManager

func _ready():
	state_collision_map = {
		"idle": [get_node(clothes_col), get_node(left_spread_col), get_node(right_spread_col), get_node(clit_col), get_node(vagaga_hole_col), get_node(anal_col)],
		"takeoffpant": [get_node(clothes_col)],
		"takeoffpanty": [get_node(clothes_col)],
		"rightspread": [get_node(right_spread_col), get_node(left_spread_col), get_node(clit_col), get_node(vagaga_hole_col), get_node(anal_col)],
		"leftspread": [get_node(left_spread_col), get_node(right_spread_col), get_node(clit_col), get_node(vagaga_hole_col), get_node(anal_col)],
		"clitcaress": [get_node(clit_col)],
		"clitlick": [get_node(clit_col)],
		"pussyfingering": [get_node(vagaga_hole_col)],
		"analfingering": [get_node(anal_col)],
		"cunnilingus": [get_node(vagaga_hole_col)],
		"anallick": [get_node(anal_col)]
		# Add other states and their collisions here
	}
	 #Instantiate TwitchManager and add it as a child
	#twitch_manager = TwitchManager.new() #this line cause infinity recursion
	#add_child(twitch_manager)


	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		previous_state = current_state
		Global.back_state = current_state.name.to_lower()


func _process(delta):
	if current_state:
		current_state.Update(delta)
	pussy.visible = !clothes_area.visible
	anal_control.visible = !clothes_area.visible


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
	Global.back_state = state_name
	
	# Start twitching based on the new state
	#twitch_manager._start_twitching([state_name])

func set_previous_state(value: State) -> void:
	previous_state = value

func get_previous_state() -> State:
	return previous_state
