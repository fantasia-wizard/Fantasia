extends KinematicBody2D

var velocity = 0
var value = 0

func _process(delta: float) -> void:
	$Number.text = str(value)
	velocity = move_and_slide(Vector2.UP*2.0+Vector2(0, velocity)).y
	if velocity <= -50:
		queue_free()


func set_value(new_value):
	value = new_value
