extends Control

@export var Address = "192.0.0.1"
@export var port = 8910

var peer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func peer_connected(id):
	print("Player Connected" + str(id))

func peer_disconnected(id):
	print("Player Disconnected" + str(id))
	
func connected_to_server():
	print("Connected To Server")
	send_player_information.rpc_id(1, $NinePatchRect/LineEdit.text, multiplayer.get_unique_id())

func connection_failed(id):
	print("Connection Failed")

@rpc("any_peer")
func send_player_information(name, id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] = {
			"name": name,
			"id": id,
			"score": 0
		}
	
	if multiplayer.is_server():
		for i in GameManager.Players:
			send_player_information.rpc(GameManager.Players[i].name, i)

@rpc("any_peer", "call_local")
func start_game():
	var scene = load("res://scene/world.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func _on_create_pressed() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 10)
	if error != OK:
		print("Cannot host " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players...")
	send_player_information($NinePatchRect/LineEdit.text, multiplayer.get_unique_id())

func _on_join_pressed() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/Home.tscn")

func _on_inizia_partita_pressed() -> void:
		start_game.rpc()
