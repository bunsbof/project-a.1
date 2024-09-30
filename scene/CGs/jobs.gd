extends Node2D

@onready var story_telling = $StoryTelling

var dialog = [
	tr("job_big_text_1"),
	tr("job_big_text_2"),
	tr("job_big_text_3"),
	tr("job_big_text_4"),
]

var background = tr("job_title")


func _ready():
	if Global.already_seen["jobs"]:
		story_telling.queue_free()
	Data.connect("language_changed", Callable(self, "_on_language_changed"))
	_on_language_changed()
	
	Global.already_seen["jobs"] = true



func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/HUD/hud.tscn")


func _on_story_telling_tree_exited():
	$Label.visible = true

func _on_language_changed():
	dialog
	background
