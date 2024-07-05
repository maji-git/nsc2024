extends Control
class_name ClassSelect


func _ready():
	pass


func _process(delta):
	pass


func select_class(btn_id):
	var btns: Array[String] = [
		"warrior"
	]
	
	btns[btn_id-1]


func _on_warrior_selected():
	select_class(1)


func _on_select_sharpshooter_pressed():
	select_class(2)


func _on_select_mage_pressed():
	select_class(3)


func _on_select_thief_pressed():
	select_class(4)
