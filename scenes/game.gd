extends Node

@onready var main_game = %MainGame
@onready var class_select = %ClassSelectWindow

signal game_started(player_class: GlobalUtils.CharactorClass)

func _ready():
	main_game.process_mode = Node.PROCESS_MODE_DISABLED


func _input(event):
	if event.is_action_pressed("quit game"):
		get_tree().quit()


func _on_class_select_class_selected(class_type: GlobalUtils.CharactorClass):
	main_game.visible = true
	class_select.visible = false
	main_game.process_mode = Node.PROCESS_MODE_ALWAYS
	class_select.process_mode = Node.PROCESS_MODE_DISABLED
	game_started.emit(class_type)

	
