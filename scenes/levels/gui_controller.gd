class_name GUIController
extends CanvasLayer

@onready var inventory_panel = %InventoryPanel
@export var inv_opened: bool = false

func _ready():
	inventory_panel.visible = inv_opened


func _on_main_game_inventory_toggled():
	inv_opened = !inv_opened
	inventory_panel.visible = inv_opened
