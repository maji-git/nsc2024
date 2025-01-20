extends Node2D

var attacking := false
var damage := 10
var player: Player

func _ready():
	%Hitbox.process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta):
	if !player.is_local:
		return
	look_at(get_global_mouse_position())

func _input(event):
	if !player.is_local:
		return
	if event.is_action_pressed("primary attack"):
		if !attacking:
			rpc("sweep")

@rpc("call_local", "reliable", "authority")
func sweep():
	%Hitbox.process_mode = Node.PROCESS_MODE_ALWAYS
	$AnimationPlayer.play("sweep")
	attacking = true

func _on_animation_player_finished(anim_name: String):
	if anim_name == "sweep":
		%Hitbox.process_mode = Node.PROCESS_MODE_DISABLED
		attacking = false


func _on_hitbox_body_entered(body):
	if !player.is_local:
		return
	if body is Enemy:
		var enemy: Enemy = body as Enemy
		enemy.take_damage(damage)
