extends Node

func transition_scene(scene: String, location: Vector2):
# warning-ignore:return_value_discarded
	PlayerStats.start_location = location
	get_tree().change_scene(scene)

func _on_Area2D_area_entered(area):
	PlayerStats.save_game()
	PlayerStats.start_location = Vector2(830, -233)
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://Forest-1/Forest-1.tscn')


func _on_Area2D2_area_entered(area):
	PlayerStats.save_game()
	PlayerStats.start_location = Vector2.ZERO
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://Buildings/Farmhouse.tscn')

func _on_Player_death():
	PlayerStats.load_game()
	transition_scene('res://Buildings/PlayerHouse.tscn', Vector2(150, 100))

func _process(delta: float) -> void:
	$CaveEntrance.visible = PlayerStats.quest_id == 8 or 8 in PlayerStats.quests_completed



func _on_Area2D3_area_entered(area: Area2D) -> void:
	if PlayerStats.quest_id == 8 or 8 in PlayerStats.quests_completed:
		transition_scene('res://Cave-1/Cave-1.tscn', Vector2.ZERO)
	else:
		pass
