class_name ClassStats
extends Resource

enum Points { ONE, TWO, THREE }

@export var name := ''
@export var weapon: PackedScene
@export var HP: Points
@export var MP: Points
@export var ATK: Points
@export var SPD: Points
@export var MULTIPLIER: Dictionary = {
	"HP": 2,
	"MP": 2,
	"ATK": 2,
	"SPD": 2
}

func set_base_stats(target: Player):
	target.base_stats = {
		"HP": HP + 1,
		"MP": MP + 1,
		"ATK": ATK + 1,
		"SPD": SPD + 1
	}
	
	target.initial_stats = {
		"HP": HP + 1,
		"MP": MP + 1,
		"ATK": ATK + 1,
		"SPD": SPD + 1
	}
	
	target.stats_multiplier = MULTIPLIER

