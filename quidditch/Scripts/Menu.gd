extends VBoxContainer

func _ready():
	pass


func _on_HostButton_pressed():
	$StatusLabel.text = "hosting 1/14 players"
	$PlayButton.disabled = false
	pass # replace with function body


func _on_JoinButton_pressed():
	$StatusLabel.text = "joining 2/14 players"
	pass # replace with function body


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
	pass # replace with function body
