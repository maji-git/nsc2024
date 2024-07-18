extends State
class_name EnemyFollowingState


var spd := 100
@export var enemy: Enemy
@export var player: Player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	print('follwing!')

func physics_process(delta):
	var dir := player.global_position - enemy.global_position
	if dir >= Vector2.RIGHT:
		enemy.animated_sprite_2d.flip_h = false
	else:
		enemy.animated_sprite_2d.flip_h = true
	enemy.velocity = dir.normalized() * spd

