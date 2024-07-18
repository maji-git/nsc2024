extends Panel
class_name AbilityPod

@export var texture: CompressedTexture2D
@export var hotkey := ""
#var cooldown := 0.05


func _enter_tree():
	$CenterContainer/TextureRect.texture = texture
	$ColorRect/Panel/Label.text = hotkey
	#$Timer.wait_time = cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
