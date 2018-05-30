extends VBoxContainer

var teams = []
var teamIndex = 0
var positions = []
var positionIndex = 0

func _ready():
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
	$StatusLabel.text = "hosting 1/14 players"
	$PlayButton.disabled = false


func _on_JoinButton_pressed():
	$StatusLabel.text = "joining 2/14 players"


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
