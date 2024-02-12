extends Node2D

var note = load("res://Scenes/note.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_timer_timeout():
	var instance = note.instantiate()
	instance.position = $Marker2D.global_position
	add_child(instance)
	
	
