extends Control

@onready var resume_btn = $CenterContainer/VBoxContainer/ResumeBtn
@onready var load_btn = $CenterContainer/VBoxContainer/LoadBtn
@onready var setting_btn = $CenterContainer/VBoxContainer/SettingBtn
@onready var main_menu_btn = $CenterContainer/VBoxContainer/MainMenuBtn
@onready var exit_btn = $CenterContainer/VBoxContainer/ExitBtn


@export var main_menu_path: String = "res://scene/menus/main_menu.tscn"
var _is_paused = false

var is_paused: bool:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _ready():
	self.is_paused = false
	_on_language_changed()
	Data.connect("language_changed", Callable(self, "_on_language_changed"))

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
		get_tree().quit()

func save_game():
	var save_game = SaveGame.new()
	save_game.horny_level = Data.horny_level
	save_game.female_point = Data.female_point
	save_game.money = Data.money
	save_game.already_seen = Global.already_seen
	save_game.write_savegame(save_game, 0) #config this later on

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		var save_game = SaveGame.new()
		save_game.horny_level = Data.horny_level
		save_game.female_point = Data.female_point
		save_game.money = Data.money
		save_game.already_seen = Global.already_seen
		save_game.write_savegame(save_game, 0) #this also
		self.is_paused = not _is_paused

func _on_resume_btn_pressed():
	self.is_paused = false

func _on_exit_btn_pressed():
	var save_game = SaveGame.new()
	save_game.horny_level = Data.horny_level
	save_game.female_point = Data.female_point
	save_game.money = Data.money
	save_game.already_seen = Global.already_seen
	save_game.write_savegame(save_game, 0) #this
	get_tree().quit()


func _on_main_menu_btn_pressed():
	#Do some save stuff
	get_tree().paused = true
	get_tree().change_scene_to_file(main_menu_path)


func _on_language_changed():
	TranslationServer.set_locale(Data.current_language)
	resume_btn.text = tr("continue")
	main_menu_btn.text = tr("main_menu")
	load_btn.text = tr("load")
	setting_btn.text = tr("settings")
	exit_btn.text = tr("quit")
