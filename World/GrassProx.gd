tool
extends Area2D

func _process(delta: float) -> void:
	if get_overlapping_areas().size() > 0:
		get_parent().global_position += get_overlapping_areas()[0].global_position.direction_to(global_position)*2
