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

func destroy(score):
	$Explosion.emitting = true
	$Timer.start()
	$Sprite2D.visible = false
	if score == 3:
		$Label.text = "PERFECT"
		$Label.modulate = Color(0.11610390990973, 0.76490116119385, 0.98519545793533)
	elif score == 2:
		$Label.text = "GREAT"
		$Label.modulate = Color(0.0580497533083, 0.50723731517792, 0.65784513950348)
	elif score == 1:
		$Label.text = "OKAY"
		$Label.modulate = Color(0.08347775787115, 0.36744633316994, 0.33009067177773)

func initialize():
	position = SPAWN
	speed = DIST_TO_TARGET / 1.5


func _on_timer_timeout():
	queue_free()
