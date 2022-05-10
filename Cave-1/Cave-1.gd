extends Node2D

func transition_scene(scene: String, location: Vector2):
# warning-ignore:return_value_discarded
	PlayerStats.start_location = location
	get_tree().change_scene(scene)

func _on_Player_death() -> void:
	PlayerStats.load_game()
	transition_scene('res://Buildings/PlayerHouse.tscn', Vector2(150, 100))


func _on_ToForest2_area_entered(area: Area2D) -> void:
	PlayerStats.save_game()
	transition_scene("res://Forest-2/Forest-2.tscn", Vector2(850, 570))

func _ready() -> void:
	if not PlayerStats.quest_id == 8 and PlayerStats.has_quest == true:
		$YSort/Enemies/Boulder.queue_free()
