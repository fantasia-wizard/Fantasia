tool
extends Area2D

export var destination: String
export var location: Vector2
export var save: bool
export var shape: Shape2D

func _on_Door_area_entered(area: Area2D) -> void:
	PlayerStats.start_location = location
	if save:
		PlayerStats.save_game()
# warning-ignore:return_value_discarded
	get_tree().change_scene(destination)

func _process(delta: float) -> void:
	$CollisionShape2D.shape = shape
