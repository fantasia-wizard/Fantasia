extends AnimatedSprite

func _on_GrassBreak_animation_finished():
	queue_free()
