class_name Player
extends CharacterBody2D

signal lvl_up(lvl: String, lvl_xp_need: int)
signal xp_changed(curr_xp: String, max_lvl_xp: String)
signal player_class_selected(player_class: GlobalUtils.CharactorClass)
signal player_base_stats_init(player: Player)

var dir := Vector2.ZERO
var last_dir := Vector2.ZERO
@export var speed = 100
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
var player_class: GlobalUtils.CharactorClass
var base_stats := {}
var stats := {}
var live_stats := { "HP": 0, "MP": 0 }
const xp_data_path := "res://scripts/objects/xp_data.json"
const MAX_LVL := 3

var xp_data = {}
var lvl: int = 1:
	set(val):
		lvl = val
		
		if val == MAX_LVL:
			lvl_up.emit("MAX", "MAX")
			return
		
		lvl_up.emit(str(val), str(get_max_xp_lvl(str(val))))

var curr_xp: int = 0:
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


func get_xp_data():
	var file = FileAccess.open(xp_data_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data


func get_max_xp_lvl(l: String) -> int:
	return xp_data[l].need


func _on_main_gui_hp_lvl_up():
	curr_xp += 100


func _ready():
	xp_data = get_xp_data()
	print(xp_data)


func on_item_picked(item: Item):
	print(item.name)


func _on_player_class_selected(player_class: GlobalUtils.CharactorClass):
	var classname := GlobalUtils.new().get_player_classnames(player_class)
	var stats_resource := load("res://resources/classes/%s.tres" % classname.to_lower()) as ClassStats 
	stats_resource.set_base_stats(self)
	stats = base_stats
	live_stats = { "HP": base_stats.HP, "MP": base_stats.MP }
	player_base_stats_init.emit(self)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	dir = Input.get_vector("move left", "move right", "move up", "move down")
	move_and_slide()

