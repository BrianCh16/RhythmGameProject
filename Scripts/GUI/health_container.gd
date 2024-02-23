extends HBoxContainer

var hearts = preload("res://Scenes/GUI/heart_gui.tscn")


func set_max_hearts(max: int):
	for i in range(max):
		var instance = hearts.instantiate()
		add_child(instance)


func update_hearts(current_health: int):
	var hearts = get_children()
	
	#whole hearts
	for i in range(current_health):
		hearts[i].update(true)
	
	#empty hearts
	for i in range(current_health, hearts.size()):
		hearts[i].update(false)
