extends Node2D

#testing ssh commit changes
#score related
var score = 0
var combo = 0
var max_combo = 0
var perfect = 0
var great = 0
var okay = 0
var missed = 0

#beat related
var spawn_1_beat = 1
var spawn_2_beat = 0
var spawn_3_beat = 0
var spawn_4_beat = 0
var can_fire = false

#onready
@onready var player = $Player
@onready var gun_ui = $Player/gun_UI
@onready var health = $"CanvasLayer/Health Container"

#load
var note = preload("res://Scenes/note.tscn")
var laser : PackedScene = preload("res://Scenes/laser.tscn")
var robot : PackedScene = preload("res://Scenes/robot_enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Conductor.play_with_beat_offset(6)
	player.fire_laser.connect(_on_player_fire_laser)
	player.health_changed.connect(health.update_hearts)
	gun_ui.sync_shot.connect(_on_gunUI_can_fire)
	gun_ui.increment_score.connect(_on_gunUI_increment_score)
	health.set_max_hearts(5)
	#var instance = robot.instantiate()
	#$Projectiles.add_child(instance)

# Called when player enters boss detection radius
func _on_boss_start_game():
	$Conductor.play_with_beat_offset(6)
	

func _on_player_fire_laser(player_pos, player_dir):
	if can_fire:
		$laser_sound.play()
		var instance = laser.instantiate() as Area2D
		instance.scale = Vector2(0.5, 0.5)
		instance.position = player_pos
		instance.direction = player_dir
		instance.rotation = player_dir.angle()
		$Projectiles.add_child(instance)
		can_fire = false


func _on_gunUI_can_fire():
	can_fire = true


func _spawn_notes(to_spawn):
	if to_spawn > 0:
		var instance = note.instantiate()
		instance.scale = Vector2(1.8,1.6)
		instance.initialize()
		
		$Player.add_child(instance)


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
	if beat_position > 32:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 0
		spawn_4_beat = 0
	if beat_position > 65:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1


func _on_gunUI_increment_score(note_score):
	if note_score > 0:
		combo += 1
	else:
		combo = 0
	
	if note_score == 3:
		perfect += 1
	elif note_score == 2:
		great += 1
	elif note_score == 1:
		okay += 1
	else:
		missed += 1
	
	
	score += note_score * combo
	$Player/Label.text = "Score: " + str(score)
	if combo > 0:
		$Player/Combo.text = str(combo) + " Combo!"
		if combo > max_combo:
			max_combo = combo
	else:
		$Player/Combo.text = "Combo dropped"

