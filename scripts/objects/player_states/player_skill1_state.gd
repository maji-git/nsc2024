extends State
class_name PlayerSkill1State

@onready var state_machine: StateMachine = %StateMachine
@export var player: Player
var player_class: String 
# { WARRIOR, SHARPSHOOTER, MAGE, THEIF }
func enter():
	player.velocity = Vector2.ZERO
	print('fuck you')

func exit():
	pass

func physics_process(delta):
	if Input.is_action_just_pressed("skill 1"):
		print('changing state')
		change_state.emit('idle')
	match player.player_class:
		GlobalUtils.CharactorClass.MAGE:
			$"../../Circle2D".visible = true
			if Input.is_action_just_pressed("primary attack"):
				print('air strike incoming')
				$"../../Circle2D".visible = false
				print('clicked; changing state')
				change_state.emit('idle')
