extends CharacterBody2D

@export var speed = 300.0

var player_position

@onready var player = $"../../Player"


func _ready():
	$Explosion.visible = false

func _physics_process(delta):
	player_position = player.position
	velocity = speed * (player_position - position).normalized()
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	print(body)
	speed = 0
	$Explosion.visible = true
	$AnimationPlayer.play("Explosion")

func _on_area_2d_area_entered(area):
	print(area)
