extends Area2D

@export var speed : int = 1000

var direction

func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.is_in_group("player"):
		return

	if "is_enemy" in body:
		body.hit()
	queue_free()
