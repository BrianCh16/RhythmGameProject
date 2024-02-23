extends CharacterBody2D

@export var speed = 300.0

var player_position

var is_enemy : bool = true

@onready var player = $"../../Player"


func _ready():
	$Explosion.visible = false

func _physics_process(delta):
	player_position = player.position
	velocity = speed * (player_position - position).normalized()
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.damage()
		speed = 0
		$Explosion.visible = true
		$AnimationPlayer.play("Explosion")
	
func hit():
	speed = 0
	$HitFlash.play("hit_flash")
	await $HitFlash.animation_finished
	$AnimationPlayer.play("Death")
