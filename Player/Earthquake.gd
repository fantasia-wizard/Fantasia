extends Area2D

var knockback_strength = 150
var damage = 2

func _process(delta: float) -> void:
	damage = 2 + PlayerStats.magic
