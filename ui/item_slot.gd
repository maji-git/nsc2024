class_name ItemSlot
extends PanelContainer

@export var current_item: Item : set = _item_set
var amount := 0:
	set(val):
		amount = val
		%Label.text = str(val)

func _item_set(item: Item):
	current_item = item
	print("%s added" % item.name)
	%TextureRect.texture = item.icon
	tooltip_text = item.name

func _ready():
	if current_item:
		_item_set(current_item)
	pass
