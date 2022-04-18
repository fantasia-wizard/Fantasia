extends StaticBody2D

export var text = 'Hello World';

onready var detection = $Area2D
onready var label = $CanvasLayer/Label
signal text_show

func display_text():
	emit_signal('text_show')
	get_tree().paused = true
	label.visible = true

func hide_text():
	get_tree().paused = false
	label.visible = false

func _process(_delta):
	label.text = text
	if Input.is_action_just_pressed('ui_accept'):
		hide_text()
	if get_tree().paused == false:
		hide_text()

func _on_Area2D_area_exited(_area):
	hide_text()


func _on_Area2D_area_entered(_area):
	display_text()
