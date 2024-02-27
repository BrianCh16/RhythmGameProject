extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var sprite = $"Boss Sprite"

var direction : Vector2
var look_player : bool = false: 
	set(value): look_player = value


func _ready():
	set_physics_process(false)

func _process(delta):
	direction = player.position - position
	if look_player:
		look_at(player.position)

func _physics_process(delta):
	velocity = direction.normalized() * 100
	move_and_collide(velocity * delta)
