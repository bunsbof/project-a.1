extends Node2D

@onready var story_telling = $StoryTelling

var dialog = [
	'Jobs scene Officiis iure rerum voluptates a cumque velit quibusdam sed amet tempora. Sit laborum ab, eius fugit doloribus tenetur fugiat, temporibus enim commodi iusto libero magni deleniti',
	'Jobs scene Voluptatem quaerat non architecto ab laudantium modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam totam ratione voluptas quod exercitationem fuga',
	'Jobs scene Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut!',
	'Jobs scene Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem',
]

var background = "Jobs Background playing in storytelling"


func _ready():
	if Global.already_seen["jobs"]:
		story_telling.queue_free()



func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/HUD/hud.tscn")


func _on_story_telling_tree_exited():
	$Label.visible = true
