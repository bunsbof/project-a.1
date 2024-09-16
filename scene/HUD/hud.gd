extends Control


@export_group("Related Node")
@export var slider_menu : NodePath
@export var toggle_menu : NodePath
@export var sub_menu : NodePath
@export var horny_bar_node : NodePath
@export var male_bar_node : NodePath
@export var female_bar_node : NodePath

var slider : TextureRect
var togglebtn : Button
var submenu : HBoxContainer
var horny_bar: TextureProgressBar
var male_bar: TextureProgressBar
var female_bar: TextureProgressBar


var is_mouse_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	togglebtn = get_node(toggle_menu)
	slider = get_node(slider_menu)
	submenu = get_node(sub_menu)
	horny_bar = get_node(horny_bar_node)
	male_bar = get_node(male_bar_node)
	female_bar = get_node(female_bar_node)
	slider.modulate.a = 0.0
	for button in slider.get_children():
		if button is Button:
			button.connect("mouse_entered", Callable(self, "_on_slider_menu_mouse_entered"))
			button.connect("mouse_exited", Callable(self, "_on_slider_menu_mouse_exited"))
	slider.mouse_filter = Control.MOUSE_FILTER_PASS
	
	Data.connect("point_changed", Callable(self, "_on_point_changed"))
	horny_bar.value = Data.point
	male_bar.value = Data.point
	female_bar.value = Data.point
	

func _physics_process(delta):
	slider.visible = Global.back_state == "idle" and Global.front_state == "idle"

func _on_button_4_pressed():
	if Data.trust_level >= 4:
		Data.trust_level = 0
	Data.trust_level += 1
	print(Data.trust_level)


func _on_slider_menu_gui_input(event):
	if event is InputEventMouseMotion:
		var local_mouse_pos = self.get_local_mouse_position()
		var rect = Rect2(Vector2(0, 0), self.custom_minimum_size)
		if rect.has_point(local_mouse_pos):
			if not is_mouse_over:
				is_mouse_over = true
				_on_slider_menu_mouse_entered()
		else:
			if is_mouse_over:
				is_mouse_over = false
				_on_slider_menu_mouse_exited()


func _on_slider_menu_mouse_entered():
	slider.modulate.a = 1.0


func _on_slider_menu_mouse_exited():
	slider.modulate.a = 0.0


func _on_pant_btn_pressed():
	Global.pant_visibility = !Global.pant_visibility


func _on_panty_btn_pressed():
	Global.panty_visibility = !Global.panty_visibility


func _on_shirt_btn_pressed():
	Global.emit_signal("shirt_on_off")


func _on_pause_btn_pressed():
	print("cac")


func _on_tongue_btn_pressed():
	Global.lickable = !Global.lickable


func _on_toggle_btn_pressed():
	submenu.visible = !submenu.visible


func _on_point_changed(new_point):
	update_health(new_point)

func update_health(new_value):
	horny_bar.value = clamp(new_value, 0, 1000)
	male_bar.value = clamp(new_value, 0, 1000)
	female_bar.value = clamp(new_value, 0, 1000)
	


func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://scene/CGs/jobs.tscn")
