extends Node2D

export var heart_number = 'heart'

func _ready():
	if heart_number in PlayerStats.hearts_collected:
		queue_free()

func _on_Area2D_area_entered(_area):
	PlayerStats.extra_hearts += 2
	PlayerStats.health +=2
	queue_free()
	PlayerStats.hearts_collected.append(heart_number)
