class_name TitleScreen
extends Control

@export var next_scene: PackedScene

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(next_scene)
