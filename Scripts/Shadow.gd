extends Sprite2D


func _ready():
	shadow()

func set_property(shadow_pos, shadow_scale):
	position = shadow_pos
	scale = shadow_scale

func shadow():
	var tween_fade = get_tree().create_tween()
	$AnimationPlayer.play()
	tween_fade.tween_property(self, "self_modulate", Color(0, 0, 0, 0), 0.75)
	await tween_fade.finished
	
	queue_free()
