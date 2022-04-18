extends Area2D

func _shield_blast():
	for x in get_overlapping_areas():
		x.strength = 750
		x.get_parent().shield_blast()
