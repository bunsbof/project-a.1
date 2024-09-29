extends Control

@export var main_gameplay_path: String = "res://scene/HUD/hud.tscn"

func _ready():
	var save_game = SaveGame.new()
	save_game.ensure_save_directory_and_files()

func _on_resume_btn_pressed():
	Data.saved_index = 0
	var loaded_game = SaveGame.load_savegame(Data.saved_index)
	if loaded_game:
		Data.trust_level = loaded_game.trust_level
		Data.point = loaded_game.point
		Data.money = loaded_game.money
		get_tree().change_scene_to_file(main_gameplay_path)
	else:
		print("Failed to load the save game.")


func _on_new_game_btn_pressed():
	var save_game = SaveGame.new()
	save_game.trust_level = 1
	save_game.point = 70.0
	save_game.money = 2146.0

	save_game.write_savegame(save_game, 0)

	Data.trust_level = save_game.trust_level
	Data.point = save_game.point
	Data.money = save_game.money
	get_tree().change_scene_to_file(main_gameplay_path)
