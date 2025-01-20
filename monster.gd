extends CharacterBody2D
class_name Enemy

@onready var state_machine: StateMachine = $StateMachine
@export var player: Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer = $Timer

@export var hp = 50:
	set(val):
		hp = val
		$ProgressBar.value = val
		if val <= 0:
			#player.curr_xp += 200
			$ProgressBar.visible = false
			$AnimatedSprite2D.visible = false
			$DetectionArea.monitoring = false
			$AttackRange.monitoring = false
			timer.start()
			#$CollisionShape2D.queue_free()
			$Label.visible = true

func _physics_process(delta):
	if multiplayer.is_server():
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

func take_damage(by: int):
	rpc("_net_take_damage", by)

@rpc("any_peer", "call_local", "reliable")
func _net_take_damage(by: int):
	hp = hp - by

func _on_attack_attacked(dmg: int):
	pass
	#player.live_stats.HP -= dmg
	#player.live_stats_changed.emit(5, 0)


func _on_timer_timeout():
	queue_free()
