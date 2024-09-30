extends Node

signal trust_level_changed
signal point_changed
signal language_changed

var saved_index = 0

var trust_level = 1:
	set(value):
		trust_level = value
		emit_signal("trust_level_changed")

var point: float = 70:
	set(value):
		point = value
		emit_signal("point_changed", point)
var money: float = 2146

var current_language : String = "ja":
	set(locale):
		TranslationServer.set_locale(locale)
		current_language = locale
		emit_signal("language_changed")

func _ready():
	var save_game = SaveGame.new()
	save_game.ensure_save_directory_and_files()
	call_deferred("_load_initial_save")

func _load_initial_save() -> void:
	var save_game = SaveGame.load_savegame(0)
	if save_game != null:
		current_language = save_game.current_language
	else:
		print("No save file found or failed to load.")
