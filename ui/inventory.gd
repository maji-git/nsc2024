extends Control
@onready var grid = %GridSlots

var inv = {}
func _ready():
	_start()
	add(ItemsEnum.AxeIII, 99)
	add(ItemsEnum.Hook)
	

func _start():
	for i in range(25):
		var item_slot := load("res://ui/item.tscn")
		var slot_instance = item_slot.instantiate()
		grid.add_child(slot_instance)

func add(item, amt=1):
	if item in inv:
		inv[item] += amt
	else:
		inv[item] = amt
	
	var idx = 0
	for itm in inv:
		var ref = grid.get_child(idx)
		ref.current_item = itm
		ref.amount = inv[itm]
		idx += 1
