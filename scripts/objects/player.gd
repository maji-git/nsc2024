class_name Player
extends CharacterBody2D

signal lvl_up(lvl: String, lvl_xp_need: int)
signal xp_changed(curr_xp: String, max_lvl_xp: String)
signal player_class_selected(player_class: GlobalUtils.CharactorClass)
signal player_base_stats_init(player: Player)
signal stat_point_changed(stat_points: int)
signal player_stat_changed
signal live_stats_changed(hp_diff: int, mp_diff: int)
signal player_died
signal no_mp
signal clicked

var speed := 0
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@export var MAX_LVL := 3

enum Skill {ONE, TWO, THREE, C, X, Z}
var dir := Vector2.ZERO
var last_dir := Vector2.ZERO
var casting_skill := false
var player_class: GlobalUtils.CharactorClass
var base_stats := {}
var initial_stats := {}
var stats_multiplier := {}
var stats := {}
var live_stats := { "HP": 0, "MP": 0 }
var intial_live_stats := { "HP": 0, "MP": 0 }
const xp_data_path := "res://scripts/objects/xp_data.json"
var curr_skill: Skill

var xp_data = {}
var lvl := 1:
	set(val):
		lvl = val
		
		if val == MAX_LVL:
			stat_points += 2
			lvl_up.emit("MAX", "MAX")
			return
		
		stat_points += 2
		lvl_up.emit(str(val), str(get_max_xp_lvl(str(val))))


var curr_xp := 0:
	set(val):
		curr_xp = val
		var max_xp = get_max_xp_lvl(str(lvl))
		
		if val == max_xp and lvl < MAX_LVL:
			lvl += 1
			val -= max_xp
			curr_xp = 0
			return
		
		if lvl == MAX_LVL:
			val = 0
			return
		
		xp_changed.emit(str(val), str(max_xp))


var stat_points := 0:
	set(val):
		stat_points = val
		stat_point_changed.emit(val)


var inv = {
	"copper": 0,
	"lead": 0,
	"titanium": 0,
	"aluminium": 0
}

func get_xp_data():
	var file = FileAccess.open(xp_data_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data


func get_max_xp_lvl(l: String) -> int:
	return xp_data[l].need


func _on_main_gui_hp_lvl_up():
	curr_xp += 100


func _input(event):
	if event.is_action_pressed("skill 1"):
		print('casting')
		match player_class:
			GlobalUtils.CharactorClass.WARRIOR:
				skill_warrior(Skill.ONE)
			GlobalUtils.CharactorClass.SHARPSHOOTER:
				skill_sharpshooter(Skill.ONE)
			GlobalUtils.CharactorClass.MAGE:
				skill_mage(Skill.ONE)
			GlobalUtils.CharactorClass.THEIF:
				skill_thief(Skill.ONE)


func _ready():
	xp_data = get_xp_data()
	print(xp_data)


func _on_player_class_selected(player_class: GlobalUtils.CharactorClass):
	var classname := GlobalUtils.new().get_player_classnames(player_class)
	var stats_resource := load("res://resources/classes/%s.tres" % classname.to_lower()) as ClassStats 
	var weapon := stats_resource.weapon.instantiate() as Weapon
	weapon.player = self
	add_child(weapon)
	stats_resource.set_base_stats(self)
	stats = base_stats
	live_stats = { "HP": base_stats.HP * 50, "MP": base_stats.MP * 50 }
	speed = 150 + (base_stats["SPD"] * 50)
	print(initial_stats)
	player_base_stats_init.emit(self)



func _physics_process(_delta):
	dir = Input.get_vector("move left", "move right", "move up", "move down")
		
	move_and_slide()


func _on_player_stat_changed():
	var get_new_stats := func(intial_stats_multiplier: int, intial_stats_adder: int,  i: String):
		var initial = initial_stats[i]
		var real = stats[i]
		var mul = stats_multiplier[i]
		print("%s:\nintial stat: %s, real_stat: %s, multiplier: %s" % [i, initial, real, mul])
		return (intial_stats_adder + (initial * intial_stats_multiplier)) + ((real - initial) * mul)
	print("stats keys:",stats.keys())
	for i in stats.keys():
		print(i, ":", initial_stats[i])
		match i:
			"HP", "MP":
				live_stats[i] = get_new_stats.call(50, 0, i)
				live_stats_changed.emit(0, 0)
				stats
			"SPD":
				speed = get_new_stats.call(50, 150, i)


func _on_ground_item_item_picked_up(itm: Item):
	pass # TODO


func _on_live_stats_changed(_hp_diff: int, _mp_diff: int):
	print(live_stats)
	if live_stats.HP <= 0:
		player_died.emit()
	
	if live_stats.MP <= 0:
		no_mp.emit()


func _on_player_died():
	process_mode = Node.PROCESS_MODE_DISABLED


func skill_warrior(skill: Skill):
	pass


func skill_sharpshooter(skill: Skill):
	pass


func skill_mage(skill: Skill):
	match skill:
		Skill.ONE:
			var ab = preload("res://scenes/skills/mage_skill1.tscn")
			var v = ab.instantiate()
			add_child(v)

func skill_thief(skill: Skill):
	pass
