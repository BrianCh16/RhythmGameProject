extends Panel

@onready var sprite = $heart

func update(whole: bool):
	if whole:
		sprite.frame = 0
	else:
		sprite.frame = 1
