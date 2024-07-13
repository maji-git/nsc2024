extends VBoxContainer

@export var player_class: ClassStats
@export var class_icon: CompressedTexture2D

signal pressed

@onready var texture_rect = $HBoxContainer/TextureRect

func _ready():
	var texts: Array[Label] = [$HP, $MP, $ATK, $SPD]
	
	%Label.text = player_class.name
	for i in texts:
		i.text = "%s: %d/3" % [i.name, player_class[i.name] + 1]
	texture_rect.texture = class_icon



func _on_select_pressed():
	pressed.emit()
