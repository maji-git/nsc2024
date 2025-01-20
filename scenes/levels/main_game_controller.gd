extends Node2D
class_name MainGame

signal inventory_toggled

@export var inv_opened = false
@onready var local_player: Player
@onready var main_gui = $MainGUI
@onready var monster_arcane_room = $ArcaneRoom


@export var player_spawner: MultiplayerSpawner

var host_port: int = 6942
var online_peer: MultiplayerPeer

func _ready():
	player_spawner.spawn_function = spawn_player
	if OS.has_feature("server"):
		host()
	else:
		join("ws://127.0.0.1:6942")
	#host()

func host(port = 6942):
	print("Server Started!")
	
	online_peer = WebSocketMultiplayerPeer.new()
	online_peer.create_server(port)
	
	multiplayer.multiplayer_peer = online_peer
	multiplayer.peer_connected.connect(_network_player_connected)
	multiplayer.peer_disconnected.connect(_network_player_disconnected)
	
	#_network_player_connected(1)

func join(url):
	online_peer = WebSocketMultiplayerPeer.new()
	online_peer.create_client(url)

	multiplayer.multiplayer_peer = online_peer
	multiplayer.connected_to_server.connect(_client_connected)
	multiplayer.server_disconnected.connect(_client_disconnected)
	multiplayer.connection_failed.connect(_client_connect_failed)
	print("Connecting...")

func spawn_player(data):
	var plr = preload("res://scenes/objects/player.tscn").instantiate()
	plr.name = str(data.peer_id)
	plr.peer_id = data.peer_id
	
	if data.peer_id == multiplayer.get_unique_id():
		print("IS_LOCAL")
		plr.is_local = true
		local_player = plr
		gv.local_player = plr
		main_gui.init_gui()
		plr.get_node("MainCam").enabled = true
	
	plr.set_multiplayer_authority(data.peer_id)
	
	return plr

func _network_player_connected(peer_id):
	print("PEER CONNECTED")
	player_spawner.spawn({peer_id = peer_id})

func _network_player_disconnected(peer_id):
	$Players.get_node(str(peer_id)).queue_free()

func _client_connected():
	print("Connected")

func _client_disconnected():
	print("Disconnected")

func _client_connect_failed():
	print("Connection Failed")

func _input(event):
	if event.is_action_pressed("debug_host"):
		host()
	if event.is_action_pressed("debug_join"):
		join("ws://127.0.0.1:6942")
	
	if event.is_action_pressed("open inventory"):
		inventory_toggled.emit()
	 
	#if event.is_action_pressed("primary attack"):
		#var mouse_pos = get_viewport().get_mouse_position()
		#GlobalUtils.new().get_cursor_quadrant(mouse_pos, player)


func _on_game_game_started(player_class: GlobalUtils.CharactorClass):
	if !local_player:
		return
	print("Player Class: %s" % GlobalUtils.new().get_player_classnames(player_class))
	local_player.player_class = player_class
	local_player.player_class_selected.emit(player_class)
	main_gui.visible = true


func _on_enter_arcane_body_entered(body):
	if body is Player and body == local_player:
		local_player.global_position = monster_arcane_room.player_spawn_point.global_position
		local_player.location = "arcane"
		monster_arcane_room.spawn_monsters.emit()
