extends Node2D

var beam = preload("res://Boss_scenes/glitchia/Glitchia_beam.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move():
	position.x+=32



func _on_conductor_report_measure(beat_num):
	move()
	if beat_num%2==0:
		var y = beam.instantiate()
		y.position=position
		$attacks.add_child(y)
		y.fire(Vector2(0,648),Vector2(0,32))
		 # Replace with function body.
