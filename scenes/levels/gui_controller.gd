class_name GUIController
extends CanvasLayer

signal hp_lvl_up

@export var inv_opened: bool = false
@export var intial_lvl_max_xp: int

@onready var inventory_panel = %InventoryPanel
@onready var button: Button = $InventoryPanel/Grid/HBoxContainer/VBoxContainer/HContainer/VBoxContainer/HPUpgrade/Button
@onready var xp_progress_bar: ProgressBar = %XPProgressBar


func _ready():
	inventory_panel.visible = inv_opened
	xp_progress_bar.max_value = intial_lvl_max_xp


func _on_main_game_inventory_toggled():
	inv_opened = !inv_opened
	inventory_panel.visible = inv_opened


func _on_button_pressed():
	hp_lvl_up.emit()


func _on_player_lvl_up(lvl: String, lvl_xp_need: String):	
	%LevelLabel.text = "LVL: %s" % lvl
	
	if lvl == "MAX" and lvl_xp_need == "MAX":
		%XPLabel.text = "XP: MAX"
		xp_progress_bar.value = 0
		button.disabled = true
		return
	
	xp_progress_bar.max_value = int(lvl_xp_need)
	%XPLabel.text = "XP: %s/%s" % [0, lvl_xp_need]


func _on_player_xp_changed(curr_xp: String, max_lvl_xp: String):
	%XPLabel.text = "XP: %s/%s" % [curr_xp, max_lvl_xp]
	xp_progress_bar.value = int(curr_xp)
	


func _on_player_player_class_selected(player_class):
	var inst := GlobalUtils.new()
	print(inst.get_player_classnames(player_class))
	%ClassLabel.text = "Class: %s" % inst.get_player_classnames(player_class)


func _on_player_player_base_stats_init(player: Player):
	%HPLabel.text = "HP: %s/%s" % [player.live_stats.HP, player.live_stats.HP]
	%MPLabel.text = "MP: %s/%s" % [player.live_stats.MP, player.live_stats.MP]
	
	var labels: Array[Label] = [%HPSLabel, %MPSLabel, %ATKLabel, %SPDLabel]
	for i in range(labels.size()):
		var idx := labels[i].name.split("L")[0]
		labels[i].text = "%s: %d" % [idx, player.base_stats[idx]]
	
