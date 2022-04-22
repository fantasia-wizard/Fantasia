extends Area2D

var knockback_vector = Vector2.ZERO
var damage = 1

func explode(_variable):
	for x in get_overlapping_areas():
		x.explode(self)

func _process(delta):
	damage = 1 + PlayerStats.magic
