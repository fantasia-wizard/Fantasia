extends AnimatedSprite

var rat = preload('res://Enemies/Rat.tscn')

func _ready():
	frame = 0
	playing = false
	$Area2D2/CollisionShape2D.disabled = false
	if colliding():
		get_parent().queue_free()


func _process(delta):
	if $Area2D.get_overlapping_areas().size() > 0:
		if not colliding():
			play()
		else:
			get_parent().queue_free()


func _on_RatEmerge_animation_finished():
	var new_rat = rat.instance()
	get_parent().get_parent().add_child(new_rat)
	new_rat.global_position = global_position + Vector2(3, -2)
	get_parent().queue_free()


func _on_Area2D2_body_entered(body):
	get_parent().queue_free()

func colliding():
	get_parent().move_and_slide(Vector2.ZERO)
	return get_parent().is_on_wall()

