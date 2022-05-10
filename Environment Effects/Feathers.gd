extends Particles2D

func _process(delta: float) -> void:
	if not emitting:
		queue_free()
