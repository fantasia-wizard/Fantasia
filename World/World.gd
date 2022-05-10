extends Node

var loaded = false
onready var forest_dialogue = $CanvasLayer/ExitToForest
onready var black_overlay = $CanvasLayer/BlackOverlay

func _ready():
# warning-ignore:standalone_expression
	if not PlayerStats.start_location and not loaded:
		PlayerStats.start_location = Vector2(-25, 125)
		loaded = true
		black_overlay.hide()
	if not PlayerStats.tutorials_completed.has($'tutorial-spells/spellbook'.name) and PlayerStats.level >= 5:
		$'tutorial-spells/spellbook'.visible = true
		PlayerStats.tutorials_completed.append($'tutorial-spells/spellbook'.name)

func transition_scene(scene: String, location: Vector2):
	black_overlay.show()
# warning-ignore:return_value_discarded
	PlayerStats.start_location = location
	PlayerStats.call_deferred('save_game')
	get_tree().change_scene(scene)

func _on_Door_area_entered(_area):
	transition_scene('res://Buildings/PlayerHouse.tscn', Vector2(150, 133))

func _on_Player_death():
	transition_scene('res://Buildings/PlayerHouse.tscn', Vector2(150, 100))


func _on_ToForest_area_entered(_area):
	get_tree().paused = true
	forest_dialogue.popup_centered()

func _on_ExitToForest_confirmed():
	get_tree().paused = false
	transition_scene('res://Forest-1/Forest-1.tscn', Vector2(14, 24))


func _on_ExitToForest_popup_hide():
	get_tree().paused = false


func _on_Area2D_area_entered(_area):
	transition_scene('res://Buildings/TownHouse-1.tscn', Vector2(27, 39))
