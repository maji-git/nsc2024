class_name GUIController
extends CanvasLayer

signal hp_lvl_up

@export var inv_opened: bool = false
@export var intial_lvl_max_xp: int
@export var player_instance: Player

@onready var inventory_panel = %InventoryPanel
@onready var xp_progress_bar: ProgressBar = %XPProgressBar


func _ready():
	inventory_panel.visible = inv_opened
	xp_progress_bar.max_value = intial_lvl_max_xp


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
	%HPLabel.text = "HP: %s/%s" % [player.live_stats.HP, player.live_stats.HP]
	%MPLabel.text = "MP: %s/%s" % [player.live_stats.MP, player.live_stats.MP]
	
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


func _on_player_live_stats_changed():
	%HPLabel.text = "HP: %s/%s" % [player_instance.live_stats.HP, player_instance.live_stats.HP]
	%MPLabel.text = "MP: %s/%s" % [player_instance.live_stats.MP, player_instance.live_stats.MP]
