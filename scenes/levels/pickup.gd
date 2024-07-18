extends Node2D
class_name GroundItem

signal item_picked_up(itm: Item)

@export var item: Item

func _ready():
	var scene = item.scene.instantiate()
	add_child(scene)

func _on_area_2d_body_entered(body):
	queue_free()
	item_picked_up.emit(item)
