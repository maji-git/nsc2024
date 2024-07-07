extends Node2D
class_name MainGame

signal inventory_toggled

@export var inv_opened = false
@onready var player: Player = $Player
@onready var main_gui = %MainGUI

func _input(event):
	if event.is_action_pressed("open inventory"):
		inventory_toggled.emit()
	
	#if event.is_action_pressed("primary attack"):
		#var mouse_pos = get_viewport().get_mouse_position()
		#GlobalUtils.new().get_cursor_quadrant(mouse_pos, player)


func _on_game_game_started(player_class: GlobalUtils.CharactorClass):
	print("Player Class: %d" %player_class)
	player.player_class_selected.emit(player_class)
	main_gui.visible = true
	player.player_class = player_class
