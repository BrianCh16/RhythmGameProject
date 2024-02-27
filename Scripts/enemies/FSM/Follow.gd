extends State


func enter():
	super.enter()
	owner.set_physics_process(true)
	owner.look_player = true
	animation_player.play("follow")
	print("follow state entered")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var distance = owner.direction.length()
	if distance < 110:
		get_parent().change_state("Melee")
	if distance > 450:
		get_parent().change_state("Dash")
