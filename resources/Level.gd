class_name Level

var enabled: bool
var activated: bool
var cg: Dictionary

func _init(enabled: bool = false, activated: bool = false, cg: Dictionary = {}):
	self.enabled = enabled
	self.activated = activated
	self.cg = cg
