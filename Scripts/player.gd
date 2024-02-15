extends CharacterBody2D


@export var speed = 200.0
@onready var anim = $AnimationPlayer
@onready var idle = $Idle
@onready var walk = $Walk
@onready var gun = $P90

func _ready():
	anim.play("Idle")
	walk.visible = false

func _physics_process(delta):
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		if direction.x < 0:
			walk.flip_h = true
			idle.flip_h = true
		elif direction.x > 0:
			walk.flip_h = false
			idle.flip_h = false
		anim.play("Walk")
		walk.visible = true
		idle.visible = false
	else:
		anim.play("Idle")
		walk.visible = false
		idle.visible = true
	velocity = direction * speed

	move_and_slide()
