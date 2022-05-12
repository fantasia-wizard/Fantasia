extends Node2D

var fight_started = false
var boss_location = Vector2.ZERO

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
	fight_started = 8 in PlayerStats.quests_completed
	boss_location = $YSort/Objects/Monolith/Boulder.global_position
	if not PlayerStats.quest_id == 8 and PlayerStats.has_quest == true:
		$YSort/Enemies/Boulder.queue_free()

func _process(delta: float) -> void:
	$'YSort/Bossfight Barrier/CollisionPolygon2D'.set_deferred('disabled', not fight_started)
	for x in  $'YSort/Bossfight Barrier Sprites'.get_children():
		x.visible = fight_started
	if not fight_started:
		$YSort/Objects/Monolith/Boulder.global_position = boss_location
	if not PlayerStats.has_quest:
		fight_started = false

func _on_Area2D_area_entered(area: Area2D) -> void:
	if not fight_started:
		PlayerStats.camera_shaking = true
		PlayerStats.shake_type = 1
		fight_started = true


func _on_Monolith_fight_finished() -> void:
	$'YSort/Bossfight Barrier Sprites'.queue_free()
	$'YSort/Bossfight Barrier'.queue_free()
