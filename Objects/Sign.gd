extends StaticBody2D

export var text = 'Hello World';

onready var detection = $Area2D
onready var label = $CanvasLayer/Label

func display_text():
	get_tree().paused = true
	label.text = text
	label.visible = true

func hide_text():
	get_tree().paused = false
	label.visible = false

func _process(_delta):
	if Input.is_action_just_pressed('ui_accept'):
		hide_text()
	if get_tree().paused == false:
		hide_text()

func _on_Area2D_area_exited(_area):
	hide_text()


func _on_Area2D_area_entered(_area):
	display_text()


func _on_TouchScreenButton_pressed() -> void:
	Input.action_press('ui_accept')
