class_name MonsterArcaneRoom
extends Node2D

signal spawn_monsters
signal exit

@onready var player_spawn_point = $PlayerSpawnPoint
@onready var room_1: Node2D = $Room1
@onready var room_2: Node2D = $Room2
@export var player: Player

#func _init(exitable: bool, exit_id: int = 0):
	#if has_exit:
		#exit = exit_id
	#
	#has_exit = exitable
	#var arr: Array[Node2D] = [$ColorRect/Passage0, $ColorRect/Passage1, $ColorRect/Passage2, $ColorRect/Passage3]
	#for i in range(4):
		#var rand_val := bool(randi_range(0,1))
		#arr[i].visible = rand_val
		#passages.append(rand_val)
		#
	#print(passages)
	#objects = [{}, {}]


func _ready():
	print('arcane room: ', player)
	for i in room_1.get_children():
		i.player = player
		print('enemy room 1: ', i.player)
	
	for i in room_2.get_children():
		i.player = player
		print('enemy room 2: ', i.player)

func _on_area_2d_2_body_entered(body):
	player.global_position = Vector2(0, 0)
