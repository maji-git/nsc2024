extends Panel
class_name AbilityPod

var texture: CompressedTexture2D
var hotkey := ""
@onready var texture_rect: TextureRect = %TextureRect
@onready var label = %Label
@onready var cooldown_overlay = $ColorRect
@onready var cooldown_text = %CooldownText

func _enter_tree():
	%TextureRect.texture = texture
	%Label.text = hotkey

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
