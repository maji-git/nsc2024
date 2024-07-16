extends State
class_name PlayerWalkState

@export var player: Player

func enter():
	pass


func physics_process(_delta):
	player.velocity = player.dir * player.speed
	match player.dir:
		Vector2.RIGHT:
			player.animated_sprite.play("side_walk")
			player.last_dir = player.dir
			player.animated_sprite.flip_h = true
		Vector2.LEFT:
			player.animated_sprite.play("side_walk")
			player.last_dir = player.dir
			player.animated_sprite.flip_h = false
		Vector2.UP:
			player.animated_sprite.play("back_walk")
			player.last_dir = player.dir
			player.animated_sprite.flip_h = false
		Vector2.DOWN:
			player.animated_sprite.play("front_walk")
			player.last_dir = player.dir
			player.animated_sprite.flip_h = false
	
	
	if player.velocity == Vector2.ZERO:
		change_state.emit(self, "idle")
	
