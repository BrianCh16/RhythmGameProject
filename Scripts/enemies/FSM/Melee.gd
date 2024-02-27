extends State

func enter():
	super.enter()
	animation_player.play("melee")
	print("melee state entered")

func transition():
	var distance = owner.direction.length()
	if distance > 110:
		get_parent().change_state("Follow")
