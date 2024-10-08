extends HBoxContainer

enum ComponentMode { Resolutions, Language }

@export var mode: ComponentMode

@onready var option_button = $OptionButton

@export_group("Title and List - Resolutions")
@export var title_res: String
@export var resolutions: Array[String]

const RESOLUTION_DICTIONARY : Dictionary = {
	"687×319" : Vector2i(687, 319),
	"1024×768" : Vector2i(1024, 768),
	"1280×1024" : Vector2i(1280, 1024),
	"1366×768" : Vector2i(1366, 768),
	"1920×1080" : Vector2i(1920, 1080)
}

@export_group("Title and List - Language")
@export var title_lang: String
@export var language: Array[String]

const LANGUAGE_DICTIONARY : Dictionary = {
	"Japan" : "ja",
	"English": "en"
}

func _ready():
	Config.connect("resolution_changed", Callable(self, "_on_resolution_changed"))
	var config = SaveConfig.load_config()
	match mode:
		ComponentMode.Resolutions:
			$Label.text = title_res
			for resolution in resolutions:
				option_button.add_item(resolution)
			var index = resolutions.find(config.resolution)
			option_button.select(index)
			option_button.connect("item_selected", Callable(self, "_on_resolution_selected"))
		ComponentMode.Language:
			$Label.text = title_lang
			for lang in language:
				option_button.add_item(lang)
			var found_key = null
			for key in LANGUAGE_DICTIONARY.keys():
				if LANGUAGE_DICTIONARY[key] == config.current_language:
					found_key = key
					break
			if found_key != null:
				var index = language.find(found_key)
				option_button.select(index)
			option_button.connect("item_selected", Callable(self, "_on_language_selected"))

func _on_resolution_selected(index: int):
	Config.resolutions = RESOLUTION_DICTIONARY.keys()[index]

func _on_resolution_changed(res):
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY[res])
	#print(res)
	var save_config = SaveConfig.new()
	save_config.resolution = res
	save_config.write_config(save_config)

func _on_language_selected(index: int):
	Data.current_language = LANGUAGE_DICTIONARY.values()[index]
	var save_lang = SaveConfig.new()
	save_lang.current_language = Data.current_language
	save_lang.write_config(save_lang)
