class_name UnlockedCG

var stanima: Dictionary
var middle: Dictionary
var love: Dictionary

func _init():
	stanima = {
		"lv1": Level.new(true, false, {
			"CG1": CG.new(false, false),
			"lv2": Level.new(false, false, {
				"CG2": CG.new(false, false),
				"lv3": Level.new(false, false, {
					"CG3": CG.new(false, false),
					"lv4": Level.new(false, false, {
						"CG4": CG.new(false, false)
					})
				})
			})
		})
	}

	middle = {
		"CG5": CG.new(false, false),
		"CG6": CG.new(false, false),
		"CG7": CG.new(false, false),
		"CG8": CG.new(false, false),
		"END": CG.new(false, false)
	}

	love = {
		"lv1": Level.new(true, false, {
			"CG9": CG.new(false, false),
			"lv2": Level.new(false, false, {
				"CG10": CG.new(false, false),
				"lv3": Level.new(false, false, {
					"CG11": CG.new(false, false),
					"lv4": Level.new(false, false, {
						"CG12": CG.new(false, false)
					})
				})
			})
		})
	}
	#connect_signals()
#
#func connect_signals():
	## Connect signals for stanima levels
	#for level in stanima.values():
		#level.connect("status_changed", Callable(self, "_on_status_changed"))
		#for cg in level.cg.values():
			#cg.connect("status_changed", Callable(self, "_on_status_changed"))
#
	## Connect signals for love levels
	#for level in love.values():
		#level.connect("status_changed", Callable(self, "_on_status_changed"))
		#for cg in level.cg.values():
			#cg.connect("status_changed", Callable(self, "_on_status_changed"))
#
	## Connect signals for middle CGs
	#for cg in middle.values():
		#cg.connect("status_changed", Callable(self, "_on_status_changed"))
#
#func _on_status_changed():
	#update_enabled_status()

func update_enabled_status():
	# Stanima branch level logic
	stanima["lv1"].cg["lv2"].enabled = stanima["lv1"].activated
	stanima["lv1"].cg["lv2"].cg["lv3"].enabled = stanima["lv1"].cg["lv2"].activated
	stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled = stanima["lv1"].cg["lv2"].cg["lv3"].activated

	# Stanima branch single parent CGs logic
	stanima["lv1"].cg["CG1"].enabled = stanima["lv1"].activated
	stanima["lv1"].cg["lv2"].cg["CG2"].enabled = stanima["lv1"].cg["lv2"].activated
	stanima["lv1"].cg["lv2"].cg["lv3"].cg["CG3"].enabled = stanima["lv1"].cg["lv2"].cg["lv3"].activated
	stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG4"].enabled = stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].activated

	# Love branch level logic
	love["lv1"].cg["lv2"].enabled = love["lv1"].activated
	love["lv1"].cg["lv2"].cg["lv3"].enabled = love["lv1"].cg["lv2"].activated
	love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled = love["lv1"].cg["lv2"].cg["lv3"].activated

	# Love branch single parent CGs logic
	love["lv1"].cg["CG9"].enabled = love["lv1"].activated
	love["lv1"].cg["lv2"].cg["CG10"].enabled = love["lv1"].cg["lv2"].activated
	love["lv1"].cg["lv2"].cg["lv3"].cg["CG11"].enabled = love["lv1"].cg["lv2"].cg["lv3"].activated
	love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG12"].enabled = love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].activated

	# Middle branch logic
	middle["CG5"].enabled = stanima["lv1"].activated and love["lv1"].activated
	middle["CG6"].enabled = stanima["lv1"].cg["lv2"].activated and love["lv1"].cg["lv2"].activated
	middle["CG7"].enabled = stanima["lv1"].cg["lv2"].cg["lv3"].activated and love["lv1"].cg["lv2"].cg["lv3"].activated
	middle["CG8"].enabled = stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].activated and love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].activated

	# End node logic
	middle["END"].enabled = middle["CG8"].activated

