extends PanelContainer

var current_item = ItemsEnum.Empty : set = _item_set
var amount = 0 : set = _amount_set

func _item_set(item):
	var atlas := AtlasTexture.new()
	atlas.atlas = load("res://assets/32rogues/items.png")
	atlas.region = Rect2(
		item[0] * 32, item[1] * 32,
		32, 32
	)
	%TextureRect2.texture = atlas
	
	current_item = item

func _amount_set(val):
	if val < 2: return
	%Label.text = str(val)

func _ready():
	_item_set(ItemsEnum.Empty)
