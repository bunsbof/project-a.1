extends Control

@export var main_gameplay_path: String = "res://scene/HUD/hud.tscn"

func _on_resume_btn_pressed():
	get_tree().change_scene_to_file(main_gameplay_path)
