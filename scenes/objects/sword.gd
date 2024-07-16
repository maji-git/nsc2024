extends Node2D

var attacking := false
var damage := 10
var player: Player

func _ready():
	%Hitbox.process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta):
	look_at(get_global_mouse_position())

func _input(event):
	if event.is_action_pressed("primary attack"):
		if !attacking:
			%Hitbox.process_mode = Node.PROCESS_MODE_ALWAYS
			$AnimationPlayer.play("sweep")
			attacking = true


func _on_animation_player_finished(anim_name: String):
	if anim_name == "sweep":
		%Hitbox.process_mode = Node.PROCESS_MODE_DISABLED
		attacking = false


func _on_hitbox_body_entered(body):
	if !body.is_in_group("Player"):
		var enemy: Enemy = body as Enemy
		enemy.hp -= damage

