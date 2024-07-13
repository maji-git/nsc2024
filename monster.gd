extends CharacterBody2D
class_name Enemy

@onready var state_machine: StateMachine = $StateMachine
@export var player: Player
var hp = 50:
	set(val):
		hp = val
		$ProgressBar.value = val

func _physics_process(delta):
	move_and_slide()


func _on_dection_area_body_entered(body):
	print(body)
	if body.is_in_group("Player"):
		if state_machine.curr_state.name.to_lower() == "idle":
			state_machine.force_change_state("following")


func _on_dection_area_body_exited(body):
	print(body)
	if body.is_in_group("Player"):
		if state_machine.curr_state.name.to_lower() == "following":
			velocity = Vector2.ZERO
			state_machine.force_change_state("idle")


func _on_attack_range_body_entered(body):
	if body.is_in_group("Player"):
		velocity = Vector2.ZERO
		state_machine.force_change_state("attack")


func _on_attack_range_body_exited(body):
	if body.is_in_group("Player"):
		if state_machine.curr_state.name.to_lower() == "attack":
			velocity = Vector2.ZERO
			state_machine.force_change_state("following")


func _on_attack_attacked(dmg: int):
	print("%d - 5 = %d" % [player.live_stats.HP, player.live_stats.HP-5])
	player.live_stats.HP -= dmg
	player.live_stats_changed.emit(5, 0)
	print("done: ", player.live_stats.HP)
