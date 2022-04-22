extends AnimatedSprite

var bat = preload('res://Enemies/Bat.tscn')

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
	var new_bat = bat.instance()
	get_parent().get_parent().add_child(new_bat)
	new_bat.global_position = get_parent().global_position + Vector2(0, -10)
	get_parent().queue_free()


func _on_Area2D2_body_entered(body):
	get_parent().queue_free()

func colliding():
	get_parent().move_and_slide(Vector2.ZERO)
	return get_parent().is_on_wall()
