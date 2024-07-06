extends Node2D

@export var item: Item

func _ready():
	var scene = item.scene.instantiate()
	add_child(scene)

func _on_area_2d_body_entered(body):
	if body.has_method("on_item_picked"):
		body.on_item_picked(item)
		queue_free()
