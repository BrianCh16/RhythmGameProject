extends Sprite2D

var perfect = false
var great = false
var okay = false
var current_note

@export var input = ""

signal sync_shot
signal increment_score(note)


func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			if current_note != null:
				if perfect:
					current_note.destroy(3)
					increment_score.emit(3)
				elif great:
					current_note.destroy(2)
					increment_score.emit(2)
				elif okay:
					current_note.destroy(1)
					increment_score.emit(1)
				sync_shot.emit()
				_reset()
			else:
				increment_score.emit(0)


func _on_okayArea_area_entered(area):
	if area.is_in_group("note"):
		okay = true
		current_note = area

func _on_greatArea_area_entered(area):
	great = true


func _on_perfectArea_area_entered(area):
	perfect = true


func _on_perfectArea_area_exited(area):
	perfect = false


func _on_greatArea_area_exited(area):
	great = false


func _on_okayArea_area_exited(area):
	okay = false
	current_note = null


func _on_missedArea_area_entered(area):
	increment_score.emit(0)


func _reset():
	current_note = null
	perfect = false
	great = false
	okay = false
