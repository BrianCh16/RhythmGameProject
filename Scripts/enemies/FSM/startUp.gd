extends State

@onready var progress_bar = owner.find_child("ProgressBar")
@onready var detection = $"../../PlayerDetection/CollisionShape2D"


var player_entered : bool = false:
	set(value):
		player_entered = value
		progress_bar.set_deferred("visible", value)
		detection.set_deferred("disabled", value)


func enter():
	animation_player.stop()
	super.enter()
	print("startup state entered")

func _on_player_detection_body_entered(body):
	animation_player.play()
	player_entered = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "start":
		get_parent().change_state("Follow")
