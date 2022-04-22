extends Control

onready var text = $Text

func _ready() -> void:
	text.rect_position.y = 180

func _process(delta: float) -> void:
	text.rect_position.y -= 30*delta
	if text.rect_position.y < -4346:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://UI/Main Menu.tscn")


func _on_Button_pressed() -> void:
 #warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/Main Menu.tscn")
