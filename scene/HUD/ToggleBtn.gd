extends Button

func _on_pressed():
	# Get the parent container
	var container = self.get_parent()
	for child in container.get_children():
		if child is Button and child != self:
			child.visible = !child.visible
