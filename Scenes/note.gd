extends Area2D

func _physics_process(delta):
	$Sprite2D.set_modulate(Color(1,1,1))
	position.x -= 200 * delta
	if position.x < 500 and position.x > -50:
		$Sprite2D.set_modulate(Color(0.337, 0.349, 0.325))
	elif position.x < -50:
		queue_free()


func initialize():
	pass
