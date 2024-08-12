extends Label

@onready var back_state_machine = $"../BackStateMachine"

func _process(delta):
	self.text = "State: " + back_state_machine.current_state.name
