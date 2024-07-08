class_name ArcaneRoom
extends Node2D

var passages: Array[bool]
var has_exit: bool
var objects: Array[Dictionary]
var exit: int

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
		
