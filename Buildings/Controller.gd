extends Node2D

func _on_Door_area_entered(_area):
	PlayerStats.start_location = Vector2(70, 225)
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://World/World.tscn')

