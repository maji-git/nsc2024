extends Control
class_name ClassSelect

signal class_selected(class_type: GlobalUtils.CharactorClass)
@export var main_scene: PackedScene


func select_class(btn_id: int):
	var classes: Array[GlobalUtils.CharactorClass] = [
		GlobalUtils.CharactorClass.WARRIOR,
		GlobalUtils.CharactorClass.SHARPSHOOTER,
		GlobalUtils.CharactorClass.MAGE,
		GlobalUtils.CharactorClass.THEIF
	]
	
	print("class %s"%btn_id)
	class_selected.emit(classes[btn_id - 1])


func _on_warrior_selected():
	select_class(1)


func _on_select_sharpshooter_pressed():
	select_class(2)


func _on_select_mage_pressed():
	select_class(3)


func _on_select_thief_pressed():
	select_class(4)
