extends TextureProgressBar


  # Starting health

func _ready():
	Data.connect("point_changed", Callable(self, "_on_point_changed"))
	self.value = Data.point

func _on_point_changed(new_point):
	update_health(new_point)

func update_health(new_value):
	self.value = clamp(new_value, 0, 1000)
