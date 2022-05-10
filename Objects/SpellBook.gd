extends Node2D

onready var ui = $CanvasLayer/Control

enum{
	EXPLODE
	SHIELD
	EARTHQUAKE
}

var locked_spell = preload('res://UI/spell_locked.png')
var earthquake_text = preload('res://UI/earthquake_spell_text.png')

func _process(_delta):
	if PlayerStats.level >= 3:
		pass
	else:
		visible = false
	if ui.visible:
		get_tree().paused = true
	if PlayerStats.level < 7:
		$CanvasLayer/Control/TextureRect/CenterContainer2/Earthquake/Label.text = 'Spell is locked.'
		$CanvasLayer/Control/TextureRect/CenterContainer2/Earthquake/Label2.texture = locked_spell
	else:
		$CanvasLayer/Control/TextureRect/CenterContainer2/Earthquake/Label.text = 'Explodes nearby enemies, dealing damage.'
		$CanvasLayer/Control/TextureRect/CenterContainer2/Earthquake/Label2.texture = earthquake_text


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


func _on_Earthquake_pressed() -> void:
	if PlayerStats.level >= 7:
		PlayerStats.selected_spell = 2.0
		ui.visible = false
		get_tree().paused = false

