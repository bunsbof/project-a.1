extends Node

signal trust_level_changed
signal point_changed
signal language_changed


var trust_level = 1:
	set(value):
		trust_level = value
		emit_signal("trust_level_changed")

var point: float = 70:
	set(value):
		point = value
		emit_signal("point_changed", point)
var money: float = 2146

var current_language : String:
	set(locale):
		TranslationServer.set_locale(locale)
		current_language = locale
		emit_signal("language_changed")

func _ready():
	var save_game = SaveGame.new()
	save_game.ensure_save_directory_and_files()
	var save_config = SaveConfig.new()
	save_config.ensure_save_directory_and_files()
	call_deferred("_load_initial_save")

func _load_initial_save() -> void:
	var saved_config = SaveConfig.load_config()
	print(saved_config.current_language)
	if saved_config != null:
		current_language = saved_config.current_language
		Config.full_screen = saved_config.full_screen
		Config.resolutions = saved_config.resolution
		if Config.full_screen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_size(Vector2(Config.resolutions.split("×")[0].to_int(), Config.resolutions.split("×")[1].to_int()))

	else:
		print("No save file found or failed to load.")
