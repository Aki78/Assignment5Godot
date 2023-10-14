extends Node2D

@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer

const Player = preload("res://Player.tscn")
const PORT = 9999

var enter_peer = ENetMultiplayerPeer.new()

func _unhandled_input(event):
	if Input.is_action_just_pressed('quit'):
		get_tree().quit()
		
func _on_host_button_pressed():
	var id = randi_range(0, 1000000)
	main_menu.hide()
	enter_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enter_peer
	

	multiplayer.peer_connected.connect(add_player)
	add_player(id)
	print("Creating Server")
	
func _on_join_button_pressed():
	main_menu.hide()
	enter_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enter_peer
	

#	multiplayer.peer_connected.connect(add_player)
#	add_player(multiplayer.get_unique_id())
	print("pressed")


	
func add_player(peer_id):
	randomize()
	var player = Player.instantiate()
	player.name = str(peer_id)

#	player.set_multiplayer_authority(peer_id)
	print("new player created: ",player.name)
	
	add_child(player)


