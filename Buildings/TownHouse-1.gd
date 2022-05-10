extends Node2D

func transition_scene(scene: String, location: Vector2):
# warning-ignore:return_value_discarded
	PlayerStats.start_location = location
	PlayerStats.call_deferred('save_game')
	get_tree().change_scene(scene)

func _on_Door_area_entered(_area):
	transition_scene('res://World/World.tscn', Vector2(-328, 210))
