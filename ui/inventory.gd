class_name InventoryUI
extends Control
@onready var grid = %GridSlots
@export var items: Item

var inv = {
	"copper": 0,
	"lead": 0,
	"titanium": 0,
	"aluminium": 0
}

func _ready():
	add_slots()
	add(load("res://resources/items/copper.tres"))
	

func add_slots():
	var items: Array[Item] = []
	
	for i in range(4):
		var res = load("res://resources/items/%s.tres" % inv.keys()[i])
		items.append(res)
		
	for i in range(4):
		var item_slot := load("res://ui/item_slot.tscn")
		print("adding: %s" % items[i].name)
		var slot_instance := item_slot.instantiate() as ItemSlot
		slot_instance.current_item = items[i]
		grid.add_child(slot_instance)


func add(item: Item, amt=1):
	inv[item.name.to_lower()] += amt
	
	var idx = 0
	for itm in inv:
		var ref := grid.get_child(idx) as ItemSlot
		ref.amount = inv[itm]
		idx += 1

