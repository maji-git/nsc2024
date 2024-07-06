class_name GlobalUtils

enum CharactorClass { WARRIOR, SHARPSHOOTER, MAGE, THEIF }
const WARRIOR_DISPLAY_NAME := "Warrior"
const SHARPSHOOTER_DISPLAY_NAME := "Sharpshooter"
const MAGE_DISPLAY_NAME := "Mage"
const THEIF_DISPLAY_NAME := "Theif"

func get_player_classnames(player_class: CharactorClass) -> String:
	match player_class:
		CharactorClass.WARRIOR:
			return WARRIOR_DISPLAY_NAME
		CharactorClass.SHARPSHOOTER:
			return SHARPSHOOTER_DISPLAY_NAME
		CharactorClass.MAGE:
			return MAGE_DISPLAY_NAME
		CharactorClass.THEIF:
			return THEIF_DISPLAY_NAME
		_:
			return WARRIOR_DISPLAY_NAME

func get_cursor_quadrant(mouse: Vector2, player_pos: Player):
	var a: ClassStats = preload("res://resources/classes/theif.tres") 
	print(a.ATK)
