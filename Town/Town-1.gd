extends Node2D

func _on_Player_death():
	PlayerStats.load_game()
	PlayerStats.start_location =  Vector2(150, 100)
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://Buildings/PlayerHouse.tscn')
