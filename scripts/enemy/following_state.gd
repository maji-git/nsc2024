extends State
class_name EnemyFollowingState


var spd := 40
@export var enemy: Enemy
@export var player: Player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	print('follwing!')

func physics_process(delta):
	var dir := player.global_position - enemy.global_position
	enemy.velocity = dir.normalized() * spd

