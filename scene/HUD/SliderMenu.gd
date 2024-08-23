extends TextureRect

var is_mouse_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a = 0.0
	for button in get_children():
		if button is Button:
			button.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
			button.connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	self.mouse_filter = Control.MOUSE_FILTER_PASS

func _physics_process(delta):
	self.visible = Global.back_state == "idle" and Global.front_state == "idle"

func _on_gui_input(event):
	if event is InputEventMouseMotion:
		var local_mouse_pos = self.get_local_mouse_position()
		var rect = Rect2(Vector2(0, 0), self.custom_minimum_size)
		if rect.has_point(local_mouse_pos):
			if not is_mouse_over:
				is_mouse_over = true
				_on_mouse_entered()
		else:
			if is_mouse_over:
				is_mouse_over = false
				_on_mouse_exited()

func _on_mouse_entered():
	self.modulate.a = 1.0

func _on_mouse_exited():
	self.modulate.a = 0.0
