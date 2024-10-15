extends Control

#Upper level buttons
@onready var stanima = $Stanima
@onready var lv_2_upper = $Stanima/Lv2_Upper
@onready var lv_3_upper = $Stanima/Lv2_Upper/Lv3_Upper
@onready var lv_4_upper = $Stanima/Lv2_Upper/Lv3_Upper/Lv4_Upper

#Upper CG buttons
@onready var cg_1 = $Stanima/CG1
@onready var cg_2 = $Stanima/Lv2_Upper/CG2
@onready var cg_3 = $Stanima/Lv2_Upper/Lv3_Upper/CG3
@onready var cg_4 = $Stanima/Lv2_Upper/Lv3_Upper/Lv4_Upper/CG4
#Middle CG buttons
@onready var cg_5 = $CG5
@onready var cg_6 = $CG6
@onready var cg_7 = $CG7
@onready var cg_8 = $CG8
@onready var end_cg = $EndCG
#Lower level buttons
@onready var love = $Love
@onready var lv_2_lower = $Love/Lv2_Lower
@onready var lv_3_lower = $Love/Lv2_Lower/Lv3_Lower
@onready var lv_4_lower = $Love/Lv2_Lower/Lv3_Lower/Lv4_Lower
#Lower CG buttons
@onready var cg_9 = $Love/CG9
@onready var cg_10 = $Love/Lv2_Lower/CG10
@onready var cg_11 = $Love/Lv2_Lower/Lv3_Lower/CG11
@onready var cg_12 = $Love/Lv2_Lower/Lv3_Lower/Lv4_Lower/CG12

func _ready():
	#stanima.get_child(1).default_color = Color("#ffffff")
	#print(stanima.get_child(1).default_color)
	pass

func _process(delta):
	#stanima level buttons
	stanima.disabled = !Data.unlocked_CG.stanima["lv1"].enabled
	stanima.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].enabled else "#393939")
	stanima.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].enabled else "#393939")
	stanima.get_child(2).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].enabled else "#393939")
	lv_2_upper.disabled = !Data.unlocked_CG.stanima["lv1"].cg["lv2"].enabled
	lv_2_upper.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].enabled else "#393939")
	lv_2_upper.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].enabled else "#393939")
	lv_2_upper.get_child(2).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].enabled else "#393939")
	lv_3_upper.disabled = !Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].enabled
	lv_3_upper.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].enabled else "#393939")
	lv_3_upper.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].enabled else "#393939")
	lv_3_upper.get_child(2).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].enabled else "#393939")
	lv_4_upper.disabled = !Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled
	lv_4_upper.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled else "#393939")
	lv_4_upper.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled else "#393939")
	#love level buttons
	love.disabled = !Data.unlocked_CG.love["lv1"].enabled
	love.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].enabled else "#393939")
	love.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].enabled else "#393939")
	love.get_child(2).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].enabled else "#393939")
	lv_2_lower.disabled = !Data.unlocked_CG.love["lv1"].cg["lv2"].enabled
	lv_2_lower.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].enabled else "#393939")
	lv_2_lower.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].enabled else "#393939")
	lv_2_lower.get_child(2).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].enabled else "#393939")
	lv_3_lower.disabled = !Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].enabled
	lv_3_lower.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].enabled else "#393939")
	lv_3_lower.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].enabled else "#393939")
	lv_3_lower.get_child(2).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].enabled else "#393939")
	lv_4_lower.disabled = !Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled
	lv_4_lower.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled else "#393939")
	lv_4_lower.get_child(1).default_color = Color("#ffffff" if Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].enabled else "#393939")
	#CGs buttons
	cg_1.disabled = !Data.unlocked_CG.stanima["lv1"].cg["CG1"].enabled
	cg_2.disabled = !Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["CG2"].enabled
	cg_3.disabled = !Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["CG3"].enabled
	cg_4.disabled = !Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG4"].enabled
	cg_5.disabled = !Data.unlocked_CG.middle["CG5"].enabled
	cg_6.disabled = !Data.unlocked_CG.middle["CG6"].enabled
	cg_7.disabled = !Data.unlocked_CG.middle["CG7"].enabled
	cg_8.disabled = !Data.unlocked_CG.middle["CG8"].enabled
	cg_8.get_child(0).default_color = Color("#ffffff" if Data.unlocked_CG.middle["CG8"].enabled else "#393939")
	end_cg.disabled = !Data.unlocked_CG.middle["END"].enabled
	cg_9.disabled = !Data.unlocked_CG.love["lv1"].cg["CG9"].enabled
	cg_10.disabled = !Data.unlocked_CG.love["lv1"].cg["lv2"].cg["CG10"].enabled
	cg_11.disabled = !Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["CG11"].enabled
	cg_12.disabled = !Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG12"].enabled


func _on_stanima_pressed():
	Data.unlocked_CG.stanima["lv1"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_lv_2_upper_pressed():
	Data.unlocked_CG.stanima["lv1"].cg["lv2"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_lv_3_upper_pressed():
	Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_lv_4_upper_pressed():
	Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_love_pressed():
	Data.unlocked_CG.love["lv1"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_lv_2_lower_pressed():
	Data.unlocked_CG.love["lv1"].cg["lv2"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_lv_3_lower_pressed():
	Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_lv_4_lower_pressed():
	Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].activated = true
	Data.unlocked_CG.update_enabled_status()


func _on_cg_1_pressed():
	Data.unlocked_CG.stanima["lv1"].cg["CG1"].activated = true
	print("CG1 activated: ", Data.unlocked_CG.stanima["lv1"].cg["CG1"].activated)


func _on_cg_2_pressed():
	Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["CG2"].activated = true
	print("CG2 activated: ", Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["CG2"].activated)


func _on_cg_3_pressed():
	Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["CG3"].activated = true
	print("CG3 activated: ", Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["CG3"].activated)

func _on_cg_4_pressed():
	Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG4"].activated = true
	print("CG4 activated: ", Data.unlocked_CG.stanima["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG4"].activated)

func _on_cg_5_pressed():
	Data.unlocked_CG.middle["CG5"].activated = true
	print("CG5 activated: ", Data.unlocked_CG.middle["CG5"].activated)

func _on_cg_6_pressed():
	Data.unlocked_CG.middle["CG6"].activated = true
	print("CG6 activated: ", Data.unlocked_CG.middle["CG6"].activated)

func _on_cg_7_pressed():
	Data.unlocked_CG.middle["CG7"].activated = true
	print("CG7 activated: ", Data.unlocked_CG.middle["CG7"].activated)


func _on_cg_8_pressed():
	Data.unlocked_CG.middle["CG8"].activated = true
	Data.unlocked_CG.update_enabled_status()
	print("CG8 activated: ", Data.unlocked_CG.middle["CG8"].activated)


func _on_end_cg_pressed():
	Data.unlocked_CG.middle["END"].activated = true
	print("END activated: ", Data.unlocked_CG.middle["END"].activated)

func _on_cg_9_pressed():
	Data.unlocked_CG.love["lv1"].cg["CG9"].activated = true
	print("CG9 activated: ", Data.unlocked_CG.love["lv1"].cg["CG9"].activated)


func _on_cg_10_pressed():
	Data.unlocked_CG.love["lv1"].cg["lv2"].cg["CG10"].activated = true
	print("CG9 activated: ", Data.unlocked_CG.love["lv1"].cg["lv2"].cg["CG10"].activated)


func _on_cg_11_pressed():
	Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["CG11"].activated = true
	print("CG9 activated: ", Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["CG11"].activated)


func _on_cg_12_pressed():
	Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG12"].activated = true
	print("CG9 activated: ", Data.unlocked_CG.love["lv1"].cg["lv2"].cg["lv3"].cg["lv4"].cg["CG12"].activated)
