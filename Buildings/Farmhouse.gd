extends Node2D

func _on_Area2D_area_entered(area):
	PlayerStats.start_location = Vector2(261, -492)
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://Forest-2/Forest-2.tscn')
