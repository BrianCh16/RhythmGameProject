extends State

var can_transition : bool = false


func enter():
	super.enter()
	animation_player.play("dash")

func dash():
	owner.look_player = false
	var tween = create_tween()
	tween.tween_property(owner, "position", player.position, 0.6)
	await tween.finished
	can_transition = true

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dash":
		dash()
