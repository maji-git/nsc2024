extends TextureRect
class_name AbilityGrid

var txture: CompressedTexture2D
var txt := ""

func _enter_tree():
	if txture:
		texture = txture
	$Label.text = txt
