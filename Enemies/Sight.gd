extends Area2D

var player = null

func _on_Sight_area_entered(area):
	player = area


func _on_AttackRange_area_entered(area):
	player = area
