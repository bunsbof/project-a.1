extends Control

@export var main_menu_path: String = "res://scene/menus/main_menu.tscn"
var _is_paused = false

var is_paused: bool:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _ready():
	self.is_paused = false

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
		get_tree().quit()

func save_game():
	var save_game = SaveGame.new()
	save_game.trust_level = Data.trust_level
	save_game.point = Data.point
	save_game.money = Data.money
	save_game.already_seen = Global.already_seen
	save_game.write_savegame(save_game, Data.saved_index)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		var save_game = SaveGame.new()
		save_game.trust_level = Data.trust_level
		save_game.point = Data.point
		save_game.money = Data.money
		save_game.already_seen = Global.already_seen
		save_game.write_savegame(save_game, Data.saved_index)
		self.is_paused = not _is_paused

func _on_resume_btn_pressed():
	self.is_paused = false

func _on_exit_btn_pressed():
	var save_game = SaveGame.new()
	save_game.trust_level = Data.trust_level
	save_game.point = Data.point
	save_game.money = Data.money
	save_game.already_seen = Global.already_seen
	save_game.write_savegame(save_game, Data.saved_index)
	get_tree().quit()


func _on_main_menu_btn_pressed():
	#Do some save stuff
	get_tree().paused = true
	get_tree().change_scene_to_file(main_menu_path)
