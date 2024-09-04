extends Control



func _on_button_4_pressed():
	if Data.trust_level >= 4:
		Data.trust_level = 0
	Data.trust_level += 1
	print(Data.trust_level)
