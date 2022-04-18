extends Area2D

var strength = 10

func colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

func push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if colliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized() * strength
	strength = 10
	return push_vector
