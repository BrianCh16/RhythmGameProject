extends Node2D

#score related
var score = 0
var combo = 0
var max_combo = 0
var perfect = 0
var great = 0
var okay = 0
var missed = 0

#beat related
var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0

#onready
@onready var player = $Player

#load
var note = preload("res://Scenes/note.tscn")
var laser : PackedScene = preload("res://Scenes/laser.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Conductor.play_with_beat_offset(6)
	player.fire_laser.connect(_on_player_fire_laser)


func _on_player_fire_laser(player_pos, player_dir):
	var instance = laser.instantiate() as Area2D
	instance.scale = Vector2(0.5, 0.5)
	instance.position = player_pos
	instance.direction = player_dir
	instance.rotation = player_dir.angle()
	$Projectiles.add_child(instance)


func _spawn_notes(to_spawn):
	if to_spawn > 0:
		var instance = note.instantiate()
		instance.scale = Vector2(3.6,3.6)
		instance.initialize()
		add_child(instance)


func _on_conductor_report_measure(measure_position):
	if measure_position == 1:
		_spawn_notes(spawn_1_beat)
	elif measure_position == 2:
		_spawn_notes(spawn_2_beat)
	elif measure_position == 3:
		_spawn_notes(spawn_3_beat)
	elif measure_position == 4:
		_spawn_notes(spawn_4_beat)


func _on_conductor_report_beat(beat_position):
	if beat_position > 18:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if beat_position > 36:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
