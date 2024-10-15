extends Node

signal horny_level_changed
signal female_point_changed
signal male_point_changed
signal language_changed


var horny_level:
	set(value):
		horny_level = value
		emit_signal("horny_level_changed", value)

var female_point: float:
	set(value):
		female_point = value
		emit_signal("female_point_changed", female_point)

var male_point: float:
	set(value):
		male_point = value
		emit_signal("male_point_changed", male_point)

var money: float
var unlocked_CG = UnlockedCG.new()
#var unlocked_cg = {
	#"stanima" : {
		#"lv1": {
			#"enabled": true,
			#"activated": false,
			#"CG1": {
				#"enabled": false,
				#"activated": false,
			#},
			#"lv2": {
				#"enabled": false,
				#"activated": false,
				#"CG2": {
					#"enabled": false,
					#"activated": false,
				#},
				#"lv3": {
					#"enabled": false,
					#"activated": false,
					#"CG3": {
						#"enabled": false,
						#"activated": false,
					#},
					#"lv4": {
						#"enabled": false,
						#"activated": false,
						#"CG1": {
							#"enabled": false,
							#"activated": false,
						#},
					#}
				#}
			#}
		#}
	#},
	#"middle": {
		#"CG1": {
			#"enabled": false,
			#"activated": false,
		#},
		#"CG6": {
			#"enabled": false,
			#"activated": false,
		#},
		#"CG7": {
			#"enabled": false,
			#"activated": false,
		#},
		#"CG8": {
			#"enabled": false,
			#"activated": false,
		#},
		#"END": {
			#"enabled": false,
			#"activated": false,
		#},
	#},
	#"horny" : {
		#"lv1": {
			#"enabled": true,
			#"activated": false,
			#"CG1": {
				#"enabled": false,
				#"activated": false,
			#},
			#"lv2": {
				#"enabled": false,
				#"activated": false,
				#"CG2": {
					#"enabled": false,
					#"activated": false,
				#},
				#"lv3": {
					#"enabled": false,
					#"activated": false,
					#"CG3": {
						#"enabled": false,
						#"activated": false,
					#},
					#"lv4": {
						#"enabled": false,
						#"activated": false,
						#"CG1": {
							#"enabled": false,
							#"activated": false,
						#},
					#}
				#}
			#}
		#}
	#},
#}

var current_language : String:
	set(locale):
		TranslationServer.set_locale(locale)
		current_language = locale
		emit_signal("language_changed")

func _ready():
	var save_game = SaveGame.new()
	save_game.ensure_save_directory_and_files()
	var save_config = SaveConfig.new()
	save_config.ensure_save_directory_and_files()
	call_deferred("_load_initial_save")
	#print("Previous: ")
	#print(unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].activated)


func _load_initial_save() -> void:
	var saved_config = SaveConfig.load_config()
	if saved_config != null:
		current_language = saved_config.current_language
		Config.full_screen = saved_config.full_screen
		Config.resolutions = saved_config.resolution
		if Config.full_screen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_size(Vector2(Config.resolutions.split("×")[0].to_int(), Config.resolutions.split("×")[1].to_int()))

	else:
		print("No save file found or failed to load.")
