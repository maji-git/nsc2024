extends Weapon

func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("primary attack"):
		var bullet: Bullet = preload("res://bullet.tscn").instantiate()
		print($Marker2D.global_position, $Marker2D.global_rotation)
		bullet.global_position = $Marker2D.global_position
		bullet.global_rotation = $Marker2D.global_rotation
		bullet.atk = atk
		bullet.patk = player.stats["ATK"]
		print("bluuet: ",bullet.global_position, " ", bullet.global_rotation)
		add_child(bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
