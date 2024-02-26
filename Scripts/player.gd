extends CharacterBody2D

@export var speed = 200.0

@onready var anim = $AnimationPlayer
@onready var idle = $Idle
@onready var walk = $Walk
@onready var gun = $P90
@onready var shadow_timer = $ShadowTimer
@onready var lightning_particles = $Lightning
@onready var dash_timer = $DashTimer
@onready var dash_cooldown = $DashCooldown

signal fire_laser(player_pos, player_dir)
signal health_changed(current_health: int)

var shadow : PackedScene = preload("res://Scenes/shadow.tscn")

var health : int = 5
var dash_speed : int = 1
var can_dash : bool = true

func _ready():
	anim.play("Idle")
	walk.visible = false
	dash_cooldown.visible = false


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
	#dash
	if Input.is_action_pressed("Dash") and can_dash:
		shadow_timer.start()
		$DashTimer.start()
		$DashDuration.start()
		lightning_particles.emitting = true
		dash_cooldown.visible = true
		can_dash = false
		$DashSound.play()

	if is_dashing():
		dash_speed = 3
	else:
		dash_speed = 1
		shadow_timer.stop()
		lightning_particles.emitting = false


		#walk and idle
		if direction != Vector2.ZERO:
			anim.play("Walk")
			walk.visible = true
			idle.visible = false
		else:
			anim.play("Idle")
			walk.visible = false
			idle.visible = true

	velocity = direction * speed * dash_speed
	dash_cooldown.value = dash_timer.wait_time - dash_timer.time_left
	move_and_slide()


func damage():
	health -= 1
	health_changed.emit(health)


func add_shadow():
	var instance = shadow.instantiate()
	instance.set_property(position, scale)
	$"../Projectiles".add_child(instance)


func is_dashing():
	return !$DashDuration.is_stopped()


func _on_shadow_timer_timeout():
	add_shadow()


func _on_dash_timer_timeout():
	can_dash = true
	dash_cooldown.visible = false
