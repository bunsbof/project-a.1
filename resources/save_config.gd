class_name SaveConfig
extends Resource

const CONFIG_PATH := "user://config.tres"
@export var file_index : int = 0
@export var current_language = "ja"
@export var full_screen = false
@export var resolution = "687×319"

func ensure_save_directory_and_files() -> void:
	if not ResourceLoader.exists(CONFIG_PATH):
		var new_config := SaveConfig.new()
		new_config.current_language = current_language
		new_config.full_screen = full_screen
		new_config.resolution = resolution
		
		var err = ResourceSaver.save(new_config, CONFIG_PATH)
		if err == OK:
			print("Created config file at: %s" % CONFIG_PATH)
		else:
			print("Failed to create config file. Error: %s" % err)

func write_config(data: SaveConfig) -> void:
	current_language = data.current_language
	full_screen = data.full_screen
	resolution = data.resolution
	
	var err = ResourceSaver.save(self, CONFIG_PATH)
	if err != OK:
		print("Error saving config file: %s" % err)

static func load_config() -> SaveConfig:
	if ResourceLoader.exists(CONFIG_PATH):
		var loaded_config = ResourceLoader.load(CONFIG_PATH) as SaveConfig
		if loaded_config:
			return loaded_config
		else:
			print("Error loading config file.")
	else:
		print("Config file does not exist.")
	
	return null
