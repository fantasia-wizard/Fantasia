extends Node2D

func _ready():
	$Area2D2/CollisionShape2D.disabled = false

func _on_Area2D_area_entered(area):
	PlayerStats.health += 2
	queue_free()


func _on_Area2D2_body_entered(body):
	queue_free()
