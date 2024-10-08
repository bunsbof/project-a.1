extends Control

@onready var continue_btn = $HBoxContainer/MarginContainer/VBoxContainer/ContinueBtn
@onready var new_game_btn = $HBoxContainer/MarginContainer/VBoxContainer/NewGameBtn
@onready var load_btn = $HBoxContainer/MarginContainer/VBoxContainer/LoadBtn
@onready var setting_btn = $HBoxContainer/MarginContainer/VBoxContainer/SettingBtn
@onready var exit_btn = $HBoxContainer/MarginContainer/VBoxContainer/ExitBtn

@export var main_gameplay_path: String = "res://scene/HUD/hud.tscn"
@export var settings_path: String = "res://scene/menus/Setting.tscn"


func _ready():
	Data.connect("language_changed", Callable(self, "_on_language_changed"))
	#print(Data.current_language)
	_on_language_changed()

func _on_resume_btn_pressed():
	var loaded_game = SaveGame.load_savegame(0) #and this
	if loaded_game:
		Data.trust_level = loaded_game.trust_level
		Data.point = loaded_game.point
		Data.money = loaded_game.money
		Global.already_seen = loaded_game.already_seen
		get_tree().change_scene_to_file(main_gameplay_path)
	else:
		print("Failed to load the save game.")


func _on_new_game_btn_pressed():
	var save_game = SaveGame.new()
	save_game.trust_level = 1
	save_game.point = 70.0
	save_game.money = 2146.0
	save_game.already_seen = Global.already_seen
	save_game.write_savegame(save_game, 0)

	Data.trust_level = save_game.trust_level
	Data.point = save_game.point
	Data.money = save_game.money
	Global.already_seen = save_game.already_seen
	get_tree().change_scene_to_file(main_gameplay_path)


func _on_language_changed():
	TranslationServer.set_locale(Data.current_language)
	continue_btn.text = tr("resume")
	new_game_btn.text = tr("new_game")
	load_btn.text = tr("load")
	setting_btn.text = tr("settings")
	exit_btn.text = tr("quit")


func _on_setting_btn_pressed():
	get_tree().change_scene_to_file(settings_path)
