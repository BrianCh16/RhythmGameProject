extends State

func enter():
	owner.look_player = false
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	animation_player.play("CONDITION victory")
	await animation_player.animation_finished
	queue_free()
