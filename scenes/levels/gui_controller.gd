class_name GUIController
extends CanvasLayer

signal hp_lvl_up
signal send_player_inst(player: Player)

@export var inv_opened: bool = false
var intial_lvl_max_xp: int = 0
@export var player_instance: Player

@onready var xp_progress_bar: ProgressBar = %XPProgressBar
@onready var item_grid: InventoryUI = %ItemGrid
@onready var inventory_panel := %InventoryPanel
@onready var points_panel := %PointsPanel
@onready var abilities_panel := %AbilitiesPanel
@onready var death_overlay := %DeathOverlay

func _ready():
	inventory_panel.visible = inv_opened


func _on_main_game_inventory_toggled():
	inv_opened = !inv_opened
	inventory_panel.visible = inv_opened


func _on_add_xp_btn_pressed():
	hp_lvl_up.emit()


func _on_player_lvl_up(lvl: String, lvl_xp_need: String):
	%LevelLabel.text = "LVL: %s" % lvl
	
	if lvl == "MAX" and lvl_xp_need == "MAX":
		%XPLabel.text = "XP: MAX"
		xp_progress_bar.value = 0
		#button.disabled = true
		return
	
	xp_progress_bar.max_value = int(lvl_xp_need)
	%XPLabel.text = "XP: %s/%s" % [0, lvl_xp_need]


func _on_player_xp_changed(curr_xp: String, max_lvl_xp: String):
	%XPLabel.text = "XP: %s/%s" % [curr_xp, max_lvl_xp]
	xp_progress_bar.value = int(curr_xp)


func _on_player_player_class_selected(player_class):
	var inst := GlobalUtils.new()
	%ClassLabel.text = "Class: %s" % inst.get_player_classnames(player_class)


func _on_player_player_base_stats_init(player: Player):
	%HPLabel.text = "HP: %d" % [player.live_stats.HP]
	%MPLabel.text = "MP: %d" % [player.live_stats.MP]
	update_abilities(GlobalUtils.new().get_player_classnames(player.player_class))
	print("asdass", player.player_class)
	
	intial_lvl_max_xp = player.xp_data["1"].need
	xp_progress_bar.max_value = intial_lvl_max_xp
	%XPLabel.text = "XP: 0/%s" % intial_lvl_max_xp
	var labels: Array[Label] = [%HPLabels, %MPLabels, %ATKLabel, %SPDLabel]
	for i in range(labels.size()):
		var idx := labels[i].name.split("L")[0]
		labels[i].text = "%s: %d" % [idx, player.base_stats[idx]]


func _on_player_stat_point_changed(stat_points: int):
	print("stat point: ", bool(stat_points))
	%SkillPointLabel.text = "Skill Points: %s" % str(stat_points)
	var btns: Array[Button] = [%HPUpgradeButton, %MPUpgradeButton, %ATKUpgradeButton, %SPDUpgradeButton]
	if stat_points == 0:
		for i in btns:
			i.disabled = true
	else:
		for i in btns:
			i.disabled = false


func _on_player_player_stat_changed():
	var labels: Array[Label] = [%HPLabels, %MPLabels, %ATKLabel, %SPDLabel] 
	for i in range(labels.size()):
		var idx = labels[i].name.split("L")[0]
		print('player stat changed; %s: %s' % [idx, player_instance.stats[idx]])
		labels[i].text = "%s: %s" % [idx, player_instance.stats[idx]]


func set_player_stat_points(stat: String):
	print("setting stat: %s; %s" % [stat, str(player_instance.stats[stat])])
	player_instance.stats[stat] += 1
	player_instance.stat_points -= 1
	player_instance.player_stat_changed.emit()
	print("stat: %s; %s" % [stat, str(player_instance.stats[stat])])


func _on_hp_upgrade_button_pressed():
	set_player_stat_points("HP")
func _on_mp_upgrade_button_pressed():
	set_player_stat_points("MP")
func _on_atk_upgrade_button_pressed():
	set_player_stat_points("ATK")
func _on_spd_upgrade_button_pressed():
	set_player_stat_points("SPD")


func _on_player_live_stats_changed(hp_diff: int, mp_diff: int = 0):
	%HPLabel.text = "HP: %d" % [player_instance.live_stats.HP]
	%MPLabel.text = "MP: %d" % [player_instance.live_stats.MP]


func _on_ground_item_item_picked_up(itm: Item):
	item_grid.add(itm)
	#pickup_prompts.add_prompt(itm)


func _on_player_player_died():
	points_panel.visible = false
	abilities_panel.visible = false
	inventory_panel.visible = false
	death_overlay.visible = true


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/title_screen.tscn")
	

func update_abilities(classname: String):
	var a = DirAccess.get_files_at("res://assets/abilities/%s" % classname.to_lower())
	var b: Array[String] = []
	for i in range(a.size()):
		if i % 2 != 0:
			b.append(a[i].split(".import")[0])
			print(a[i].split(".import")[0])
	
	b.sort()
	for i in range(b.size()):
		var bar = preload("res://ability_pod.tscn")
		var barr := bar.instantiate() as AbilityPod
		barr.texture = load("res://assets/abilities/%s/%s" % [classname.to_lower(), b[i]])
		print("adding: %s" % b[i])
		barr.hotkey = b[i].split(".")[0]
		
		var arr = preload("res://ability_grid.tscn")
		var arrr := arr.instantiate() as AbilityGrid
		arrr.txt = b[i].split(".")[0]
		arrr.txture = load("res://assets/abilities/%s/%s" % [classname.to_lower(), b[i]])
		
		$InventoryPanel/CenterContainer/Grid/VBoxContainer2/AbilitiesRow1.add_child(arrr)
		$AbilitiesPanel/CenterContainer/GridContainer.add_child(barr)
	
	var bar = preload("res://ability_pod.tscn")
	var barr := bar.instantiate() as AbilityPod
	barr.texture = load("res://assets/backpack.png")
	print("adding: backpack")
	barr.hotkey = "E"
	$AbilitiesPanel/CenterContainer/GridContainer.add_child(barr)
	
