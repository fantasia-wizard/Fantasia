extends AnimatedSprite

var bat = preload('res://Enemies/Bat.tscn')

onready var area2D = $Area2D

func _ready():
	if get_parent().is_on_wall():
		get_parent().queue_free()
	frame = 0
	playing = false

func _process(delta):
	if area2D.get_overlapping_areas().size() > 0:
		play()

func _on_RatEmerge_animation_finished():
	var new_bat = bat.instance()
	get_parent().get_parent().add_child(new_bat)
	new_bat.global_position = Vector2(global_position.x, global_position.y+16)
	get_parent().queue_free()
