extends Node2D

var wheat_break = preload('res://Environment Effects/WheatBreak.tscn')

func _on_Area2D_area_entered(area):
	if area.name != 'Explosion':
		PlayerStats.experience += 1
		PlayerStats.wheat_harvested += 1
		var effect = wheat_break.instance()
		get_parent().add_child(effect)
		effect.global_position = global_position
		queue_free()
