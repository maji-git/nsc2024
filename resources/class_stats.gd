class_name ClassStats
extends Resource

enum Points {ONE, TWO, THREE}

@export var HP: Points
@export var MP: Points
@export var ATK: Points
@export var SPD: Points

func set_base_stats(target: Player):
	target.base_stats = {
		"HP": (HP+1) * 50,
		"HPS": HP + 1,
		"MP": (MP + 1) * 50,
		"MPS": MP + 1,
		"ATK": ATK + 1,
		"SPD": SPD + 1
	}
