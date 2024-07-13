extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	%Hitbox.process_mode = Node.PROCESS_MODE_DISABLED


func _input(event):
	if event.is_action_pressed("primary attack"):
		#add_child()
		%Hitbox.process_mode = Node.PROCESS_MODE_ALWAYS


func _process(delta):
	look_at(get_global_mouse_position())
	
