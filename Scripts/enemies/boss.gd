extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var sprite = $"Boss Sprite"
@onready var progress_bar = $UI/ProgressBar

signal startGame

var is_enemy : bool = true
var direction : Vector2
var look_player : bool = false: 
	set(value): look_player = value
var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		if value <= 50:
			set_process(false)
			direction = Vector2.ZERO
			$AnimationPlayer.play("extend")
			


func _ready():
	set_physics_process(false)
	var start = get_node("FiniteStateMachine/startUp")
	start.start_up.connect(_on_StartUp)

func _on_StartUp():
	startGame.emit()

func _process(delta):
	direction = player.position - position
	if look_player:
		look_at(player.position)

func _physics_process(delta):
	velocity = direction.normalized() * 100
	move_and_collide(velocity * delta)

func hit():
	health -= 10
