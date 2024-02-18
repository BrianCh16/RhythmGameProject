extends CharacterBody2D

@export var speed = 200.0

@onready var anim = $AnimationPlayer
@onready var idle = $Idle
@onready var walk = $Walk
@onready var gun = $P90
@onready var shadow_timer = $ShadowTimer
@onready var lightning_particles = $Lightning
@onready var dash_timer = $DashTimer

signal fire_laser(player_pos, player_dir)

var shadow : PackedScene = preload("res://Scenes/shadow.tscn")

var can_dash : bool = true

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
	#dash
	if Input.is_action_pressed("Dash") and can_dash:
		shadow_timer.start()
		lightning_particles.emitting = true
		$DashSound.play()
		$DashTimer.start()
		can_dash = false
		
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + velocity * 1.25, 0.4)
		direction = Vector2.ZERO
		await tween.finished
		
		shadow_timer.stop()
		lightning_particles.emitting = false
	#walk and idle
	else:
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


func add_shadow():
	var instance = shadow.instantiate()
	instance.set_property(position, scale)
	get_tree().current_scene.add_child(instance)


func _on_shadow_timer_timeout():
	add_shadow()


func _on_dash_timer_timeout():
	can_dash = true
