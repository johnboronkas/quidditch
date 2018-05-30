extends VBoxContainer

const IP = "127.0.0.1"
const PORT = 6789
const MAX_PLAYERS = 14

var avatar = null
var players = []

var teams = []
var teamIndex = 0
var positions = []
var positionIndex = 0

func _ready():
	avatar = preload("res://Scripts/Player.gd")

	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connected_to_server", self, "_connected_ok")

	populateTeams()
	populatePositions()

func populateTeams():
	teams.append("red")
	teams.append("green")
	teams.append("blue")
	teams.append("gold")
	$HBoxContainer/TeamButton.text = teams[teamIndex]

func populatePositions():
	positions.append("seeker")
	positions.append("chaser")
	positions.append("beater")
	positions.append("keeper")
	$HBoxContainer/PositionButton.text = positions[positionIndex]

func _on_TeamButton_pressed():
	teamIndex = (teamIndex + 1) % teams.size()
	$HBoxContainer/TeamButton.text = teams[teamIndex]

func _on_PositionButton_pressed():
	positionIndex = (positionIndex + 1) % positions.size()
	$HBoxContainer/PositionButton.text = positions[positionIndex]

func _on_HostButton_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, 14)
	get_tree().set_network_peer(host)

	$StatusLabel.text = "hosting - awaiting connections"

	$HostButton.disabled = true
	$JoinButton.disabled = true
	$PlayButton.disabled = false

func _on_JoinButton_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.create_client(IP, PORT) # TODO Remove hardcoded IP (move to UI)
	get_tree().set_network_peer(host)

func _connected_ok():
	rpc("register_player", get_tree().get_network_unique_id())
	get_tree().get_root().get_node("Menu").queue_free()

remote func register_player(player_id):
	var player = avatar.instance()
	player.set_network_master(player_id)
	player.name = str(player_id)
	get_tree().get_root().add_child(player)
	$StatusLabel.text = players.size() + "/" + MAX_PLAYERS + " players connected"

	# Host should tell other players about the new player
	if get_tree().get_network_unique_id() == 1:
		if player_id != 1:
			for i in players:
				rpc_id(player_id, "register_player", i)
		players.append(player_id)

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
