extends Control

@onready var rich_text_label = $Dialogue/MarginContainer/RichTextLabel
@onready var skip_btn = $Dialogue/SkipBtn
@onready var label = $Label

@export var dialog : Array

var dialog_index = 0
var finished = false
var tween
var skip_mode = false # Flag to indicate if skip mode is active

func _ready():
	dialog = get_parent().dialog
	label.text = get_parent().background
	load_dialog()
	skip_btn.connect("pressed", Callable(self, "_on_skip_pressed"))

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		rich_text_label.text = dialog[dialog_index]
		rich_text_label.visible_ratio = 0

		tween = create_tween()
		finished = false

		tween.finished.connect(self._on_dialogue_finish)

		# Set the speed depending on the skip mode
		var duration = 0.4 if skip_mode else 4.0 # Faster if skip_mode is true, else normal speed

		tween.tween_property(rich_text_label, "visible_ratio", 1.0, duration)

	else:
		Global.already_seen["jobs"] = true
		queue_free()
	dialog_index += 1

func _on_dialogue_finish():
	finished = true
	if skip_mode:
		load_dialog()

func _on_skip_pressed():
	skip_mode = !skip_mode # Toggle the skip mode

	# If skip mode is active and there is a running tween, adjust its speed
	if tween:
		if skip_mode:
			tween.set_speed_scale(5.0) # Set faster speed
		else:
			tween.set_speed_scale(1.0) # Reset to normal speed

	# If in skip mode and dialogue is finished, load next dialogue immediately
	if finished and skip_mode:
		load_dialog()
