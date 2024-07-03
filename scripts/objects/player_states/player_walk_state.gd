extends State
class_name PlayerWalkState

@export var player: Player

func enter():
	print('player started walking!')


func physics_process(delta):
	if player.velocity == Vector2.ZERO:
		Transitioned.emit(self, "idle")
