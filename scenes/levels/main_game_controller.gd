extends Node2D
class_name MainGame

signal inventory_toggled

@export var inv_opened = false

func _ready():
	pass


func _input(event):
	if event.is_action_pressed("open inventory"):
		inventory_toggled.emit()
