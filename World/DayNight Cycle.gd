extends ColorRect

var time = 225.5

func _process(delta: float) -> void:
	time += delta
	color.a = abs(cos(time/50)/2)
