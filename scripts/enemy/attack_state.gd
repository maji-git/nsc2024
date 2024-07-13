extends State
class_name EnemyAttackingState

signal attacked(dmg: int)

@export var player: Player
@onready var attack_cooldown = $"../../AttackCooldown"
var is_on_cd := false

func enter():
	print('attacking!')


func physics_process(_delta):
	if is_on_cd:
		return
	
	attack_cooldown.start()
	attacked.emit(5)
	is_on_cd = true


func _on_attack_cooldown_timeout():
	print('atk cd timeout')
	is_on_cd = false
