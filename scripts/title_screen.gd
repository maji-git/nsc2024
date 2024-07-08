class_name TitleScreen
extends Control

@export var next_scene: PackedScene
var pressed_2times := false


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(next_scene)


func _on_quit_button_pressed():
	if !pressed_2times:
		pressed_2times = true
		$CanvasLayer/VBOXContainer/Confirm.visible = true
		$Timer.start()
		return
	
	get_tree().quit()


func _on_timer_timeout():
	pressed_2times = false
	$CanvasLayer/VBOXContainer/Confirm.visible = false
