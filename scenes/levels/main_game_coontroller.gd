extends Node2D
class_name MainGame


signal inventory_toggled

@export var inv_opened = false
@onready var inventory_panel = $CanvasLayer/InventoryPanel


func _ready():
	inventory_panel.visible = inv_opened


func _input(event):
	if event.is_action_pressed("open inventory"):
		inventory_toggled.emit()


func _on_inventory_toggled():
	inv_opened = !inv_opened
	inventory_panel.visible = inv_opened
