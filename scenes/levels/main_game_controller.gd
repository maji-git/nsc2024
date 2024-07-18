extends Node2D
class_name MainGame

signal inventory_toggled

@export var inv_opened = false
@onready var player: Player = $Player
@onready var main_gui = $MainGUI
@onready var monster_arcane_room = $ArcaneRoom
@onready var main_cam = $Player/MainCam


func _input(event):
	if event.is_action_pressed("open inventory"):
		inventory_toggled.emit()
	 
	#if event.is_action_pressed("primary attack"):
		#var mouse_pos = get_viewport().get_mouse_position()
		#GlobalUtils.new().get_cursor_quadrant(mouse_pos, player)


func _on_game_game_started(player_class: GlobalUtils.CharactorClass):
	print("Player Class: %s" % GlobalUtils.new().get_player_classnames(player_class))
	player.player_class = player_class
	player.player_class_selected.emit(player_class)
	main_gui.visible = true


func _on_enter_arcane_body_entered(body):
	if body is Player:
		player.global_position = monster_arcane_room.player_spawn_point.global_position
		monster_arcane_room.spawn_monsters.emit()
