extends Node2D

onready var ui = $CanvasLayer/Control

enum{
	EXPLODE
	SHIELD
}

func _process(_delta):
	if PlayerStats.level >= 3:
		pass
	else:
		visible = false
	if ui.visible:
		get_tree().paused = true


func _on_Area2D_area_entered(_area):
	if PlayerStats.level >= 3:
		ui.visible = true
		get_tree().paused = true

func _on_Area2D_area_exited(_area):
	if PlayerStats.level >= 3:
		ui.visible = false
		get_tree().paused = false


func _on_Explode_pressed():
	PlayerStats.selected_spell = 0.0
	ui.visible = false
	get_tree().paused = false


func _on_Shield_pressed():
	PlayerStats.selected_spell = 1.0
	ui.visible = false
	get_tree().paused = false


func _on_ExitButton_pressed():
	ui.visible = false
	get_tree().paused = false
