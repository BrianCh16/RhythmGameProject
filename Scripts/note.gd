extends Area2D

const TARGET_X = 577
const SPAWN = Vector2(1200, 577)
const DIST_TO_TARGET = SPAWN.x - TARGET_X

var speed = 0

func _physics_process(delta):
	$Sprite2D.set_modulate(Color(1,1,1))
	position.x -= speed * delta
	if position.x < 500 and position.x > -50:
		$Sprite2D.set_modulate(Color(0.337, 0.349, 0.325))
	elif position.x < -50:
		queue_free()


func initialize():
	position = SPAWN
	speed = DIST_TO_TARGET / 2.0
