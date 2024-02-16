extends Area2D

@export var speed : int = 1000

var direction

func _physics_process(delta):
	position += direction * speed * delta
