extends HBoxContainer

func _ready():
	$Label.text = tr("fullscreen") + ":"
	Config.connect("fullscreen_changed", Callable(self, "_on_fullscreen_changed"))
	Data.connect("language_changed", Callable(self, "_on_language_changed"))

func _process(delta):
	if Config.full_screen:
		$CheckButton.button_pressed = true
	else: $CheckButton.button_pressed = false

func _on_check_button_toggled(toggled_on : bool):
	if toggled_on:
		Config.full_screen = toggled_on
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		Config.full_screen = toggled_on
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_fullscreen_changed(val):
	var save_config = SaveConfig.new()
	save_config.full_screen = val
	save_config.write_config(save_config)
	if save_config.full_screen:
		$CheckButton.button_pressed = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		$CheckButton.button_pressed = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_language_changed():
	TranslationServer.set_locale(Data.current_language)
	$Label.text = tr("fullscreen") + ":"
