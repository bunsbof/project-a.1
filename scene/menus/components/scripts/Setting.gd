extends Control

@onready var resolutions = $TabContainer/Resolutions
@onready var language = $TabContainer/Language

func _ready():
	Data.connect("language_changed", Callable(self, "_on_language_changed"))
	resolutions.name = tr("resolutions")
	language.name = tr("language")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/menus/main_menu.tscn")

func _on_language_changed():
	TranslationServer.set_locale(Data.current_language)
	resolutions.name = tr("resolutions")
	language.name = tr("language")
