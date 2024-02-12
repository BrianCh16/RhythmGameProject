extends Node2D
var casting=false
var tween
@onready var offset=position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func fire(pos:Vector2, start:Vector2=Vector2(0,0)):
	casting=true
	#$fireee.emitting=true
	#await $fireee.finished
	$beam.points[0]= start
	$beam.points[1] =pos
	#$object.look_at(get_global_mouse_position())
	#$line_beams.emission_rect_extents=$beam.points[1]
	#$line_beams.emitting=true
	appear()
	await tween.finished
	disappear() 
	casting=false

	
func appear():
	$beam.modulate=Color("white",255)
	
	tween=create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	
	#tween.tween_property($object,"offset",Vector2(-5,-5),0.2)
	tween.tween_property($beam,"modulate",Color("White",255),0.2)
	tween.tween_property($beam,"width",5,0.1)


	tween.chain().tween_property($beam,"modulate",Color("White",0.0),0.2)
	# tween.tween_property($object,"offset",Vector2(0,0),0.2)
	# tween.tween_property($beam,"width",20,0.2)
	
func disappear():
	queue_free()
