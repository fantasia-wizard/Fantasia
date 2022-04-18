extends AnimatedSprite

func _on_ShieldBlast_animation_finished():
	queue_free()
