class_name SaveGame
extends Resource

const SAVE_GAME_PATH := "user://savegame.tres"

@export var trust_level: int = 1
@export var point: float = 70.0
@export var money: float = 2146.0

func write_savegame(data: SaveGame) -> void:
	trust_level = data.trust_level
	point = data.point
	money = data.money
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH) as SaveGame
	return null
