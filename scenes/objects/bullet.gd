extends Node2D
class_name Bullet

var patk := 0
var atk := 0

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * 10


func _on_area_2d_body_entered(body):
	if body is Enemy:
		body.take_damage(atk * patk)
	queue_free()
