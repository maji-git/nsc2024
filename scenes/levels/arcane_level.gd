class_name ArcaneLevel
extends Node2D

@onready var monster_arcane_room: MonsterArcaneRoom = $ArcaneRoom
@export var player: Player

func _ready():
	print('arcane lvl: ', player)
	monster_arcane_room.player = player
