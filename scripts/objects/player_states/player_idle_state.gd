extends State
class_name PlayerIdleState

@export var player: Player

func enter():
	print("player idle state!")

func physics_process(delta):
	if player.velocity != Vector2.ZERO:
		Transitioned.emit(self, "walk")
