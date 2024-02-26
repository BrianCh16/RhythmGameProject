extends Node2D
class_name State

@onready var debug = owner.find_child("state debug") as Label
@onready var player = owner.get_parent().find_child("Player") as CharacterBody2D
@onready var animation_player = owner.find_child("AnimationPlayer") as AnimationPlayer


func _ready():
	set_physics_process(false)

func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	pass

func _physics_process(delta):
	transition()
	debug.text = name
