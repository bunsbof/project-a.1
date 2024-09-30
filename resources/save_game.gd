class_name SaveGame
extends Resource

const SAVE_FOLDER_PATH := "user://saved_games/"
const SAVE_FILES := [
	"user://saved_games/game_save_1.tres",
	"user://saved_games/game_save_2.tres",
	"user://saved_games/game_save_3.tres",
	"user://saved_games/game_save_4.tres"
]

@export var trust_level: int = 1
@export var point: float = 70.0
@export var money: float = 2146.0
@export var already_seen = {
	"jobs" : false
}
@export var current_language = "ja"

func ensure_save_directory_and_files() -> void:
	var dir := DirAccess.open("user://")
	if dir == null:
		print("Failed to open user directory.")
		return

	if not dir.dir_exists(SAVE_FOLDER_PATH):
		var err = dir.make_dir(SAVE_FOLDER_PATH)
		if err != OK:
			print("Failed to create directory. Error: %s" % err)
			return
		else:
			print("Save folder created.")

	for i in range(SAVE_FILES.size()):
		if not ResourceLoader.exists(SAVE_FILES[i]):
			var new_save := SaveGame.new()
			var save_err = ResourceSaver.save(new_save, SAVE_FILES[i])
			if save_err == OK:
				print("Created save file: %s" % SAVE_FILES[i])
			else:
				print("Failed to create save file: %s. Error: %s" % [SAVE_FILES[i], save_err])

func write_savegame(data: SaveGame, index: int) -> void:
	if index >= 0 and index < SAVE_FILES.size():
		trust_level = data.trust_level
		point = data.point
		money = data.money
		already_seen = data.already_seen
		current_language = data.current_language
		var err = ResourceSaver.save(self, SAVE_FILES[index])
		if err != OK:
			print("Error saving file: %s" % err)

static func load_savegame(index: int) -> SaveGame:
	if index >= 0 and index < SAVE_FILES.size() and ResourceLoader.exists(SAVE_FILES[index]):
		return load(SAVE_FILES[index]) as SaveGame
	return null
