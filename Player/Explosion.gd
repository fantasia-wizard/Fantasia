extends Area2D

var knockback_vector = Vector2.ZERO
var damage = 1

func explode():
	for x in get_overlapping_areas():
		x.explode()

func _process(delta):
	damage = 1 + PlayerStats.magic
