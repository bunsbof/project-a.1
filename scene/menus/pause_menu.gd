extends Control

@export var main_menu_path: String = "res://scene/menus/main_menu.tscn"
# Private variable to store pause state
var _is_paused = false

# Public setter for pause state
var is_paused: bool:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _ready():
	# Ensure the menu is hidden when the game starts
	self.is_paused = false

# Handle the pause input
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = not _is_paused

# Resume button press handler
func _on_resume_btn_pressed():
	self.is_paused = false

# Exit button press handler
func _on_exit_btn_pressed():
	get_tree().quit()


func _on_main_menu_btn_pressed():
	#Do some save stuff
	get_tree().paused = true
	get_tree().change_scene_to_file(main_menu_path)
