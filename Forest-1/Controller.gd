extends Node

onready var island_dialogue = $CanvasLayer/ToIsland
onready var trees = $'YSort/Tree Border'
onready var fallen_trees = $'YSort/Fallen Tree'


func transition_scene(scene: String, location: Vector2):
# warning-ignore:return_value_discarded
	PlayerStats.start_location = location
	get_tree().change_scene(scene)

func _ready():
	if PlayerStats.level >= 5:
		trees.queue_free()
		fallen_trees.visible = true
	else:
		fallen_trees.visible = false

func _on_ToIsland_area_entered(_area):
	get_tree().paused = true
	island_dialogue.popup_centered()

func _on_ToIsland_confirmed():
	get_tree().paused = false
	PlayerStats.start_location = Vector2(200, 20)
# warning-ignore:return_value_discarded
	PlayerStats.call_deferred('save_game')
	get_tree().change_scene('res://World/World.tscn')


func _on_ToIsland_popup_hide():
	get_tree().paused = false


func _on_Player_death():
	PlayerStats.load_game()
	transition_scene('res://Buildings/PlayerHouse.tscn', Vector2(150, 100))


func _on_To_Forest2_area_entered(area):
# warning-ignore:return_value_discarded
	PlayerStats.save_game()
	PlayerStats.start_location = Vector2(-110, 0)
	get_tree().change_scene('res://Forest-2/Forest-2.tscn')
