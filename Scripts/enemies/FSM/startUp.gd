extends State

@onready var progress_bar = owner.find_child("ProgressBar")

var player_entered : bool = false


func transition():
	if player_entered:
		get_parent().change_state("Follow")

func _on_player_detection_body_entered(body):
	player_entered = true
