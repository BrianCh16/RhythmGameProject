extends CharacterBody2D


@export var speed = 200.0
@onready var anim = $AnimationPlayer
@onready var idle = $Idle
@onready var walk = $Walk
@onready var gun = $P90

signal fire_laser(player_pos, player_dir)

func _ready():
	anim.play("Idle")
	walk.visible = false

func _physics_process(delta):
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	#shooting
	var laser_marker = $P90/Marker2D
	if Input.is_action_pressed("Shoot"):
		fire_laser.emit(laser_marker.global_position, player_direction)
	
	#looking
	gun.look_at(get_global_mouse_position())
	if player_direction.x < 0:
		gun.position.x = -8
		gun.flip_v = true
		walk.flip_h = true
		idle.flip_h = true
	elif player_direction.x > 0:
		gun.position.x = 8
		gun.flip_v = false
		walk.flip_h = false
		idle.flip_h = false

	#movement
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		anim.play("Walk")
		walk.visible = true
		idle.visible = false
	else:
		anim.play("Idle")
		walk.visible = false
		idle.visible = true
	velocity = direction * speed

	move_and_slide()

