extends Weapon

var attacking := false
var curr_body: Array[Enemy]
#var praticle: MageParticle
#var curr_praticle: MageParticle

#func _ready():
	#var a = preload("res://mage_attack_particle.tscn")
	#praticle = a.instantiate()
	#praticle.body_entered.connect(_on_praticle_body_entered)


func _input(event):
	if event.is_action_pressed("primary attack"):
		print(curr_body)
		if curr_body and !player.casting_skill:
			curr_body[0].hp -= player.stats["ATK"] * atk
			#add_child(praticle)
			#praticle.dir = (curr_body[0].global_position - player.global_position).normalized()
			#praticle.flying = true
			return


func _on_hitbox_body_entered(body):
	if !(body is Player) and body is Enemy:
		print("mage: ", body)
		curr_body.append(body)


func _on_hitbox_body_exited(body):
	curr_body = curr_body.filter(func(bd): return bd != body)

#
#func _on_praticle_body_entered(body):
	#if body is Player:
		#return 
	#praticle.queue_free()
	#var a = preload("res://mage_attack_particle.tscn")
	#praticle = a.instantiate()

