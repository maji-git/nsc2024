extends Node2D
class_name MageSkill1

@export var color: Color
@export var radius := 10.0
var av := false
@onready var area_2d: Area2D = $Area2D
var player: Player

func _draw():
	draw_circle(Vector2.ZERO, radius, color)


func _input(event):
	if event.is_action_pressed("primary attack"):
		for i in area_2d.get_overlapping_bodies():
			if i is Enemy:
				i.take_damage(40)
		queue_free()
		player.casting_skill = false


func _process(delta):
	global_position = get_global_mouse_position()
